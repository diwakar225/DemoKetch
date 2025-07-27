//
//  ProductListResponse.swift
//  DemoKetch
//
//  Created by Diwakar Bisht on 25/07/25.
//


import Foundation

// MARK: - Top Level Response
struct ProductListResponse: Codable {
    let query: Query?
    let success: Bool?
    let message: String?
    let count: Int?
    let pageCount: Int?
    let result: ResultData
}

// MARK: - Query Info
struct Query: Codable {
    let page: String?
    let lg: String?
    let count: String?
    let sortBy: String?
    let sortDir: String?
    let filter: String?
    let fieldspecials: String?
    let country: String?
    let additionalConfig: String?

    enum CodingKeys: String, CodingKey {
        case page
        case lg
        case count
        case sortBy = "sort_by"
        case sortDir = "sort_dir"
        case filter
        case fieldspecials
        case country
        case additionalConfig = "additional_config"
    }
}

// MARK: - Result Data
struct ResultData: Codable {
    let count: Int?
    let products: [Product]?
    let filters: [Filter]?
    let sort: [SortOption]?
}

// MARK: - Product
struct Product: Codable, Identifiable {
    var id: String?
    let name, brand, productType: String?
    let fit: String?
    let defaultSize: String?
    let sizes: [String]?
    let images: [String]?
    let gallery: [GalleryItem]?
    let color, sleeveLength, neckType, fabric: String?
    let price, sellingPrice, discount: Int?
    let overallStockStatus, countryOfOrigin, subcategory, category: String?
    let leafcategory: String?
    let variation: [Variation]?
}

struct GalleryItem: Codable {
    let url: String?
}


// MARK: - Filter
struct Filter: Codable {
    let filterLabel: String
    let isSort: Bool?
    let options: [FilterOption]

    enum CodingKeys: String, CodingKey {
        case filterLabel = "filter_lable"
        case isSort = "is_sort"
        case options
    }
}

struct FilterOption: Codable {
    let code: String
    let value: String
    let valueKey: String
    let valueCode: String?
    let index: Int?
    
    enum CodingKeys: String, CodingKey {
        case code
        case value
        case valueKey = "value_key"
        case valueCode = "value_code"
        case index
    }
}


struct Variation: Codable, Identifiable {
    let id: Int?
    let sku: String?
    let name: String?
    let size: String?
    let brand: String?
    let image: String?
    let price: Int?
    let status: String?
    let urlKey: String?
    let discount: Int?
    let groupId: String?
    let quantity: Int?
    let idProduct: Int?
    let visibility: String?
    let description: String?
    let enInPrice: Int?
    let stockStatus: String?
    let sellingPrice: Int?
    let taxPercentage: Int?
    let discountAmount: Int?
    let refundableDays: Int?
    let sizeMeasurement: [String]?
    let enInSellingPrice: Int?
    let enInDiscountAmount: Int?

    enum CodingKeys: String, CodingKey {
        case id, sku, name, size, brand, image, price, status
        case urlKey = "url_key"
        case discount
        case groupId = "group_id"
        case quantity
        case idProduct = "id_product"
        case visibility, description
        case enInPrice = "en-in_price"
        case stockStatus = "stock_status"
        case sellingPrice = "selling_price"
        case taxPercentage = "tax_percentage"
        case discountAmount = "discount_amount"
        case refundableDays = "refundable_days"
        case sizeMeasurement = "size_measurement"
        case enInSellingPrice = "en-in_selling_price"
        case enInDiscountAmount = "en-in_discount_amount"
    }
}

struct SortOption: Identifiable, Codable {
    var id: String { code ?? "" }
    let code: String?
    let label: String?
    let dir: String?
}

