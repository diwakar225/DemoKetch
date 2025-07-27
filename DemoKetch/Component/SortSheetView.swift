//
//  SortSheetView.swift
//  DemoKetch
//
//  Created by Diwakar Bisht on 27/07/25.
//


import SwiftUI

struct SortSheetView: View {
    @Binding var isPresented: Bool
    @Binding var selectedOption: String

    let sortOptions: [SortOption]
    var onOptionSelected: (String, String) -> Void

    var body: some View {
        VStack(spacing: 0) {
            Text("SORT BY")
                .font(.headline)
                .padding()

            Divider()

            List {
                ForEach(sortOptions) { option in
                    Button(action: {
                        selectedOption = option.code ?? ""
                        isPresented = false
                        onOptionSelected(option.code ?? "", option.dir ?? "desc")
                    }) {
                        HStack {
                            Text(option.label ?? "")
                                .foregroundColor(.primary)
                            Spacer()
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 6)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                            (option.code == selectedOption)
                            ? Color.blue.opacity(0.2)
                            : Color.clear
                        )
                        .cornerRadius(8)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .listStyle(.plain)
        }
        .presentationDetents([.fraction(0.5)])
    }
}
