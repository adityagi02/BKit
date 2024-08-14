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
    @State var viewModel = CategoryProductViewModel(apiHandler: ProductsDataAPIHandler())
    
    var body: some View {
        VStack(spacing: 0) {
            Divider()
            
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    VStack {
                        CategoryListingView(dataModel: viewModel)
                    }
                    .frame(width: geometry.size.width * 0.15)
                    .background(.regularMaterial)
                    
                    Divider()
                    ProductListingView(dataModel: viewModel)
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
    ContentView(viewModel: CategoryProductViewModel(apiHandler: ProductsDataAPIHandler()))
}
