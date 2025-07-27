//
//  BottomBar.swift
//  DemoKetch
//
//  Created by Diwakar Bisht on 27/07/25.
//


import SwiftUI

struct BottomBar: View {
    @Binding var isSortSheetPresented: Bool
    @Binding var showFilters: Bool
    var viewModel: DemoKetchViewModel

    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                isSortSheetPresented = true
            }) {
                HStack(spacing: 4) {
                    Image(systemName: "arrow.up.arrow.down")
                        .foregroundColor(.black)
                    Text("SORT BY")
                        .foregroundColor(.black)
                        .font(.subheadline)
                }
            }
            Spacer()
            Button(action: {
                showFilters = true
            }) {
                HStack(spacing: 4) {
                    Image(systemName: "slider.horizontal.3")
                        .foregroundColor(.black)
                    Text("FILTER")
                        .foregroundColor(.black)
                        .font(.subheadline)
                }
            }
            Spacer()
        }
        .padding()
        .background(Color.white.shadow(radius: 2))
        .sheet(isPresented: $showFilters) {
            FilterView(categories: viewModel.filterCategories)
        }
        .sheet(isPresented: $isSortSheetPresented) {
            SortSheetView(
                isPresented: $isSortSheetPresented,
                selectedOption: Binding(
                            get: { viewModel.selectedSort },
                            set: { viewModel.selectedSort = $0 }
                        ),
                sortOptions: viewModel.sorting,
                onOptionSelected: { selectedCode, selectedDir in
                    viewModel.fetchSortedProducts(sortBy: selectedCode, sortDir: selectedDir)
                }
            )
        }
    }
}
