//
//  ProductsListAPIHandler.swift
//  BKit
//
//  Created by Aditya Tyagi on 13/08/24.
//

import Foundation

protocol ProductsDataAPIHandling {
    func getGroceryData() async throws -> GroceryData
}

struct ProductsDataAPIHandler: ProductsDataAPIHandling {
    func getGroceryData() async throws -> GroceryData {
        let jsonData = mockGroceryData.data(using: .utf8)
        guard let data = jsonData else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid JSON data"])
        }

        let decoder = JSONDecoder()
        let groceryData = try decoder.decode(GroceryData.self, from: data)
        return groceryData
    }
}
