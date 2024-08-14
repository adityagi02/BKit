//
//  GroceryDataModel.swift
//  BKit
//
//  Created by Aditya Tyagi on 14/08/24.
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
    
    var isCategorySelected: Bool?


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
    /// A computed property used to determine which image to display if multiple images are available.
    var productImageIndex: Int? {
        getproductImageIndex(string: productName ?? "--")
    }

    enum CodingKeys: String, CodingKey {
        case productImageURL = "productImageUrl"
        case productName, productPrice
    }
    
    
     /// Calculates an index for the product image based on the product name.
     ///
     /// The index is derived from the hash value of the product name and is used to select
     /// a specific image from a set of images. The index is calculated to ensure it falls
     /// within a specified range.
     ///
     /// - Parameter string: The product name used to calculate the index.
     /// - Returns: An integer index value.
    func getproductImageIndex(string: String) -> Int {
        return (string.hash.hashValue % 30) * ((string.hash.hashValue % 30) > 0 ? 1 : -1)
    }
}


enum ScrollPosition: Hashable {
    /// Represents a scroll position within a product card list.
    ///
    /// This enum case stores the index of the product card associated with the scroll position.
    case productCard(index: Int)
}
