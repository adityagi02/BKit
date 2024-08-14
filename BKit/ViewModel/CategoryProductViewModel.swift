//
//  CategoryProductViewModel.swift
//  BKit
//
//  Created by Aditya Tyagi on 14/08/24.
//

import Foundation
import SwiftUI
import Combine

class CategoryProductViewModel: ObservableObject {
    /// The ID of the currently selected category.
    @Published var selectedCategoryID: Int = 0
    /// A handler for interacting with the API to fetch product data.
    private var apiHandler: ProductsDataAPIHandling
    @Published var categories: [Category]?
    @Published private var _selectedProducts: [Product] = []
    var selectedProducts: [Product] {
        get {
            return categories?.first { $0.categoryID == selectedCategoryID }?.products ?? _selectedProducts
        }
        set {
            _selectedProducts = newValue
        }
    }
    
    /// This method is executed asynchronously to fetch the grocery data from the API. If
    /// the data is successfully retrieved, it calls `setupDatasource` to update the view model
    /// with the new data.
    func onViewAppear() {
        Task {
            do {
                let fetchedData = try? await self.apiHandler.getGroceryData()
                guard let data = fetchedData else {
                    return
                }
                await setupDatasource(data: data)
            }
        }
    }
    
    /// Retrieves a category based on its ID.
    ///
    /// This method searches for a category with the specified `categoryID` in the current
    /// `categoryData`. If found, it returns the category; otherwise, it returns a default
    /// category with the name "--".
    ///
    /// - Parameter categoryID: The ID of the category to retrieve.
    /// - Returns: The category matching the given ID, or a default category if not found.
    func getCategoryFromID(categoryID: Int) -> Category {
        return categories?.first { $0.categoryID == categoryID } ?? .init(categoryName: "--")
    }
    
    /// Updates the view model with the new grocery data.
    @MainActor
    func setupDatasource(data: GroceryData) {
        self.categories = data.categories
    }
    
    init(apiHandler: ProductsDataAPIHandling){
        self.apiHandler = apiHandler
    }
    
}
