//
//  ProductsListAPIHandler.swift
//  BKit
//
//  Created by Aditya Tyagi on 13/08/24.
//

import Foundation

/// A protocol defining the API handling behavior for fetching grocery data.
protocol ProductsDataAPIHandling {

    /// Fetches grocery data asynchronously using an API.
    ///
    /// This function retrieves grocery data from a remote API source. It throws an error
    /// if the data retrieval fails.
    ///
    /// - Throws: An error if there's an issue fetching or decoding the grocery data.
    /// - Returns: A `GroceryData` object containing the fetched grocery information.
    func getGroceryData() async throws -> GroceryData
}

/// A concrete implementation of `ProductsDataAPIHandling` that retrieves grocery data
/// from a mock source.
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
