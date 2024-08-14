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
    @State private var scrollThreshold = (UIScreen.main.bounds.height * 0.25)
    /// A timer used to debounce automatic category changes based on scrolling.
    @State private var timer: Timer?
    
    /// The maximum scroll offset for the current category's products.
    private var maxScrollOffset: CGFloat {
        CGFloat((self.dataModel.getCategoryFromID(categoryID: dataModel.selectedCategoryID).products?.count ?? 3) * (-90))
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
    /// the predefined thresholds. It uses a timer to debounce category changes to avoid
    /// rapid switching.
    ///
    /// - Parameter newValue: The new scroll offset value.
    private func handleScrollOffsetChange(_ newValue: CGFloat) {
        // Scroll down to the bottom of the current category
        if newValue < maxScrollOffset && dataModel.selectedCategoryID < (dataModel.categories?.count ?? 1) - 1 {
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: false) { _ in
                dataModel.selectedCategoryID += 1
            }
        }
        // Scroll up to the top of the current category
        if newValue > scrollThreshold && dataModel.selectedCategoryID > 0 {
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: false) { _ in
                if dataModel.selectedCategoryID > 0 {
                    dataModel.selectedCategoryID -= 1
                }
            }
        }
    }
}
