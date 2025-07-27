//
//  FilterCategory.swift
//  DemoKetch
//
//  Created by Diwakar Bisht on 27/07/25.
//

import SwiftUI

struct FilterCategory: Identifiable {
    let id = UUID()
    let name: String
    let options: [String]
}

struct FilterView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedCategory: String
    @State private var selectedFilters: [String: Set<String>] = [:]

    let categories: [FilterCategory]

    init(categories: [FilterCategory]) {
        self.categories = categories
        _selectedCategory = State(initialValue: categories.first?.name ?? "")
    }

    var body: some View {
        VStack(spacing: 0) {
            Text("FILTERS")
                .font(.headline)
                .padding()

            Divider()

            HStack(spacing: 0) {
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(categories.map(\.name), id: \.self) { category in
                            Button(action: {
                                selectedCategory = category
                            }) {
                                Text(category)
                                    .foregroundColor(.black)
                                    .fontWeight(selectedCategory == category ? .bold : .regular)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding()
                                    .background(selectedCategory == category ? Color(.systemGray5) : Color.clear)
                            }
                        }.frame(width: 120)
                    }
                }



                Divider()

                // RIGHT: Options
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(categories.first(where: { $0.name == selectedCategory })?.options ?? [], id: \.self) { option in
                            Button(action: {
                                toggleSelection(for: selectedCategory, option: option)
                            }) {
                                HStack {
                                    Image(systemName: isSelected(category: selectedCategory, option: option) ? "checkmark.square" : "square")
                                        .foregroundColor(.black)
                                    Text(option)
                                        .foregroundColor(.black)
                                    Spacer()
                                }
                                .padding(.vertical, 8)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }

            Divider()

            // Bottom Bar
            HStack {
                Button("CLOSE") {
                    presentationMode.wrappedValue.dismiss()
                }
                .frame(maxWidth: .infinity)

                Divider()

                Button("APPLY") {
                    print("Selected Filters: \(selectedFilters)")
                    presentationMode.wrappedValue.dismiss()
                }
                .frame(maxWidth: .infinity)
            }
            .frame(height: 50)
            .background(Color.white)
        }
    }

    // MARK: - Helper Methods
    func toggleSelection(for category: String, option: String) {
        if selectedFilters[category]?.contains(option) == true {
            selectedFilters[category]?.remove(option)
        } else {
            selectedFilters[category, default: []].insert(option)
        }
    }

    func isSelected(category: String, option: String) -> Bool {
        selectedFilters[category]?.contains(option) ?? false
    }
}
