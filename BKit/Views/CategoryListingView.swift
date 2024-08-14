//
//  CategoryListingView.swift
//  BKit
//
//  Created by Aditya Tyagi on 14/08/24.
//

import SwiftUI

struct CategoryListingView: View {
    @ObservedObject var dataModel: CategoryProductViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            if let data = dataModel.categories {
                ForEach(data, id: \.id) { category in
                    Button(action: {
                        dataModel.selectedCategoryID = category.categoryID ?? 0
                    }) {
                        SideBarCategoryCardView(
                            selected: dataModel.selectedCategoryID == category.categoryID,
                            imageID: getImageIndex(string: category.categoryName),
                            categoryName: category.categoryName
                        )
                        .animation(.easeInOut)
                            .padding(.vertical, 8)
                    }
                }
            }
        }
    }
    
    /// Computes an image index based on the category title.
    /// - Parameter string: The string used to compute the image index.
    /// - Returns: An integer index for the image.
    func getImageIndex(string: String) -> Int {
        return (string.hash.hashValue % 30) * ((string.hash.hashValue % 30) > 0 ? 1 : -1)
    }
}
