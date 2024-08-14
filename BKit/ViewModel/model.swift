//
//  model.swift
//  BKit
//
//  Created by Aditya Tyagi on 13/08/24.
//

import Foundation

// MARK: - Grocery
struct GroceryData: Codable {
    var categories: [Category]
}

// MARK: - Category
struct Category: Codable, Hashable, Identifiable {
    var id: UUID = UUID()
    
    var categoryID: Int?
    var categoryImageURL: String?
    var categoryName: String
    var products: [Product]?


    enum CodingKeys: String, CodingKey {
        case categoryImageURL = "categoryImageUrl"
        case categoryName, products
        case categoryID
    }
    
    static func == (lhs: Category, rhs: Category) -> Bool {
        return lhs.categoryImageURL == rhs.categoryImageURL
    }
}

// MARK: - Product
struct Product: Codable, Hashable, Identifiable {
    var id: UUID = UUID()

    var productImageURL: String?
    var productName: String?
    var productPrice: Double?
    var productImageIndex: Int? {
        productPrice?.exponent
    }

    enum CodingKeys: String, CodingKey {
        case productImageURL = "productImageUrl"
        case productName, productPrice
    }
}
