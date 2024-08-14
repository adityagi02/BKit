//
//  GroceriesViewModel.swift
//  BKit
//
//  Created by Aditya Tyagi on 13/08/24.
//

import Foundation

/// A view model for managing and interacting with `GroceryData`.
///
class GroceriesViewModel: ObservableObject {
    /// The current grocery data.
    @Published var categoryData: GroceryData?
    /// The ID of the currently selected category.
    @Published var selectedCategory: Int = 0
    /// A handler for interacting with the API to fetch product data.
    private var apiHandler: ProductsDataAPIHandling
    
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
        return categoryData?.categories.first { $0.categoryID == categoryID } ?? .init(categoryName: "--")
    }
    
    
    func clearAllOtherSelected(except categoryID: Int) {
        // Ensure categoryData is not nil and has categories
        guard var categories = categoryData?.categories else {
            return
        }
        
        // Update the selection state of categories
        for index in categories.indices {
            if categories[index].categoryID == categoryID {
                categories[index].isCategorySelected = true
            } else {
                categories[index].isCategorySelected = false
            }
        }
        
        // Assign updated categories back to categoryData
        self.categoryData?.categories = categories
    }
    
    /// Updates the view model with the new grocery data.
    @MainActor
    func setupDatasource(data: GroceryData) {
        self.categoryData = data
    }
    
    init(apiHandler: ProductsDataAPIHandling){
        self.apiHandler = apiHandler
    }
}
