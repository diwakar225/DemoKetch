//
//  ContentView.swift
//  DemoKetch
//
//  Created by Diwakar Bisht on 25/07/25.

import SwiftUI

struct ProductListView: View {
    @StateObject var viewModel = DemoKetchViewModel()

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HeaderView(viewModel: viewModel)

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.variationItems) { item in
                            VariationCard(item: item)
                                .onAppear {
                                    viewModel.loadNextPageIfNeeded(currentItem: item)
                                }
                        }
                    }
                    .padding(.horizontal)
                }

                Divider()

                BottomBar(
                    isSortSheetPresented: $viewModel.isSortSheetPresented,
                    showFilters: $viewModel.showFilters,
                    viewModel: viewModel
                )
            }
            .navigationBarHidden(true)
            .blur(radius: viewModel.isLoading ? 3 : 0)
            .disabled(viewModel.isLoading)

            if viewModel.isLoading {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()

                ProgressView("Loading...")
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
            }
        }
    }
}
