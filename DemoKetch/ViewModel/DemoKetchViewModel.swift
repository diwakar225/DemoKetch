//
//  ViewModel.swift
//  DemoKetch
//
//  Created by Diwakar Bisht on 25/07/25.
//

import Foundation

@MainActor
final class DemoKetchViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var products: [Product] = []
    @Published var variationItems: [FlatVariationItem] = []
    @Published var filterCategories: [FilterCategory] = []
    @Published var sorting: [SortOption] = []
    @Published var selectedSort: String = "Newness"
    @Published var totalItemCount: Int = 0
    @Published  var isSortSheetPresented = false
    @Published  var showFilters = false

    private var currentPage = 1
    private var totalCount = 0
    private var isFetchingMore = false
    private let pageSize = 9

    init() {
        Task {
            await callApi()
        }
    }

    func callApi(sortBy: String = "product_position", sortDir: String = "desc", reset: Bool = false) async {
        if isFetchingMore { return }
        isFetchingMore = true
        await MainActor.run { self.isLoading = reset }

        let baseUrl = "https://engine.kartmax.in/api/fast/search/v1/2dc60dff02a1ebb92ad3719507f5eeb3/plp-special"
        
        var urlComponents = URLComponents(string: baseUrl)
        urlComponents?.queryItems = [
            URLQueryItem(name: "page", value: "\(currentPage)"),
            URLQueryItem(name: "lg", value: "en"),
            URLQueryItem(name: "count", value: "\(pageSize)"),
            URLQueryItem(name: "sort_by", value: sortBy),
            URLQueryItem(name: "sort_dir", value: sortDir),
            URLQueryItem(name: "filter", value: ""),
            URLQueryItem(name: "fieldspecials", value: "_uuid~5rt48iohqlw29bx704|overall_stock_status~in-stock"),
            URLQueryItem(name: "country", value: "en-in")
        ]

        guard let url = urlComponents?.url else {
            isFetchingMore = false
            await MainActor.run { self.isLoading = false }
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(ProductListResponse.self, from: data)
            let totalItem = response.result.count ?? 0
            let newProducts = response.result.products ?? []
            let newVariations: [FlatVariationItem] = newProducts.flatMap { product in
                (product.variation ?? []).compactMap { variation in
                    guard let id = variation.id else { return nil }

                    return FlatVariationItem(
                        id: id,
                        name: variation.name ?? "",
                        image: variation.image,
                        price: variation.price,
                        sellingPrice: variation.sellingPrice,
                        discount: variation.discount,
                        fit: product.fit,
                        brand: product.brand
                    )
                }
            }


            await MainActor.run {
                self.totalItemCount = totalItem
                if reset {
                    self.products = newProducts
                    self.variationItems = newVariations
                } else {
                    self.products += newProducts
                    self.variationItems += newVariations
                }

                self.sorting = response.result.sort ?? []

                if reset {
                    self.filterCategories = (response.result.filters ?? []).map {
                        FilterCategory(name: $0.filterLabel, options: $0.options.map { $0.value })
                    }
                }

                self.totalCount = response.result.products?.count ?? 0
                self.isLoading = false
            }
        } catch {
            print("❌ Error: \(error)")
            await MainActor.run { self.isLoading = false }
        }

        isFetchingMore = false
    }

    func loadNextPageIfNeeded(currentItem item: FlatVariationItem) {
        guard !isFetchingMore else { return }

        if let lastItem = variationItems.last, lastItem.id == item.id {
            currentPage += 1
            Task {
                await callApi(reset: false)
            }
        }
    }

    func fetchSortedProducts(sortBy: String, sortDir: String) {
        Task {
            self.currentPage = 1
            await callApi(sortBy: sortBy, sortDir: sortDir, reset: true)
        }
    }
}

struct FlatVariationItem: Identifiable {
    let id: Int
    let name: String
    let image: String?
    let price: Int?
    let sellingPrice: Int?
    let discount: Int?
    let fit: String?
    let brand: String?
}
