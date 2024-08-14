//
//  ProductListingView.swift
//  BKit
//
//  Created by Aditya Tyagi on 14/08/24.
//

import SwiftUI

/// A view for displaying a grid of products within a selected category.
///
struct ProductListingView: View {
    @ObservedObject var dataModel: CategoryProductViewModel
    /// The current vertical scroll offset of the `ScrollView`.
    @State private var scrollOffset: CGFloat = 0
    /// The threshold scroll offset for changing the selected category.
    @State private var scrollThreshold = (UIScreen.main.bounds.height * 0.20)
    /// A timer used to debounce automatic category changes based on scrolling.
    @State private var timer: Timer?
    @State private var isCategoryChanging = false

    
    /// The maximum scroll offset for the current category's products.
    private var maxScrollOffset: CGFloat {
        CGFloat((self.dataModel.getCategoryFromID(categoryID: dataModel.selectedCategoryID).products?.count ?? 3) * (-75))
    }
    
    var body: some View {
        VStack {
            HStack {
                // Text("\(scrollOffset)")
                Spacer()
            }
            ScrollViewReader { proxy in
                ObservableScrollView(contentOffset: $scrollOffset) {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 4) {
                        if let products = dataModel.getCategoryFromID(categoryID: dataModel.selectedCategoryID).products {
                            ForEach(products.indices, id: \.self) { index in
                                ProductCardView (
                                    imageID: ((products[index].productImageIndex ?? 20) % 20),
                                    productName: products[index].productName ?? "--",
                                    productPrice: products[index].productPrice ?? 0.00
                                )
                                .id(ScrollPosition.productCard(index: index))
                                .padding(2)
                            }
                        }
                    }
                }
                .onChange(of: scrollOffset, perform: { newValue in
                    handleScrollOffsetChange(newValue)
                })
                .onDisappear {
                    timer?.invalidate()
                }
                .onChange(of: dataModel.selectedCategoryID) { _ in
                    withAnimation {
                        proxy.scrollTo(ScrollPosition.productCard(index: 0), anchor: .top)
                    }
                }
            }
            .padding(.horizontal, 12)
        }
    }
    
    /// Handles scroll offset changes to determine if the category should be switched.
    ///
    /// This method updates the selected category based on the scroll position and
    /// the predefined thresholds.
    ///
    /// - Parameter newValue: The new scroll offset value.
    private func handleScrollOffsetChange(_ newValue: CGFloat) {
        guard !isCategoryChanging else { return }
        isCategoryChanging = true
        
        if newValue < maxScrollOffset && dataModel.selectedCategoryID < (dataModel.categories?.count ?? 1) - 1 {
            dataModel.selectedCategoryID += 1
        }
        if newValue > scrollThreshold && dataModel.selectedCategoryID > 0 {
            dataModel.selectedCategoryID -= 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            isCategoryChanging = false
        }
    }
}
