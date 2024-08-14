//
//  ContentView.swift
//  BKit
//
//  Created by Aditya Tyagi on 13/08/24.
//

import SwiftUI
/// The main view for displaying the main screen of the app.
///
struct ContentView: View {
    /// The view model for managing grocery data and category selection.
    @StateObject var viewModel = GroceriesViewModel(apiHandler: ProductsDataAPIHandler())
    /// The ID of the currently selected category.
    @State var selectedCategory: Int = 0
    
    var body: some View {
        VStack(spacing: 0) {
            
            Divider()
            
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    VStack {
                        ScrollView(showsIndicators: false) {
                            if let data = viewModel.categoryData?.categories {
                                ForEach(data, id: \.id) { section in
                                    ProductCategoryCard(
                                        title: section.categoryName,
                                        currentCategoryID: section.categoryID ?? 0,
                                        selectedCategoryID: $selectedCategory)
                                        .buttonStyle(PlainButtonStyle())
                                }
                            }
                        }
                    }
                    .frame(width: geometry.size.width * 0.15)
                    .background(.regularMaterial)
                    
                    Divider()
                    
                    ProductListingView(category: viewModel.getCategoryFromID(categoryID: selectedCategory), selectedCategoryID: $selectedCategory, totalCategories: viewModel.categoryData?.categories.count ?? 1)
                }
            }
            
            Divider()
        }
        .onAppear() {
            viewModel.onViewAppear()
        }
    }
}

#Preview {
    ContentView(viewModel: GroceriesViewModel(apiHandler: ProductsDataAPIHandler()))
}

/// A view representing a button for selecting a product category.
///
struct ProductCategoryCard: View {
    /// The title of the category to display.
    var title: String
    /// The ID of the category represented by this card.
    var currentCategoryID: Int
    /// A local state to manage whether the category card is selected.
    @State var selected: Bool = false
    /// A binding to the selected category ID.
    @Binding var selectedCategoryID: Int
    
    var body: some View {
        Button(action: {
            self.selected = true
            self.selectedCategoryID = currentCategoryID
        }) {
            SideBarCategoryCardView(
                selected: $selected,
                imageID: getImageIndex(string: title),
                categoryName: title
            )
                .padding(.vertical, 8)
        }
    }
    
    /// Computes an image index based on the category title.
    /// - Parameter string: The string used to compute the image index.
    /// - Returns: An integer index for the image.
    func getImageIndex(string: String) -> Int {
        return (string.hash.hashValue % 30) * ((string.hash.hashValue % 30) > 0 ? 1 : -1)
    }
}
