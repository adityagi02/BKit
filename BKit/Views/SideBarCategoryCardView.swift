//
//  SideBarCategoryCardView.swift
//  BKit
//
//  Created by Aditya Tyagi on 14/08/24.
//

import SwiftUI

/// A view representing a category card in the sidebar.
///
struct SideBarCategoryCardView: View {
    /// A binding to a Boolean value indicating whether the category is selected.
    var selected: Bool
    /// The identifier for the image to be displayed.
    var imageID: Int
    /// The name of the category.
    var categoryName: String
    /// The URL for the category image.
    private var imageURL: URL? {
        URL(string: "https://picsum.photos/id/\(imageID)/200/300")
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 6) {
            productImageView
            productInfoView
        }
        .shadow(radius: selected ? 14 : 0)
    }
    
    @ViewBuilder
    private var productImageView: some View {
        ZStack(alignment: .topLeading) {
            AsyncImage(url: imageURL) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
                    .frame(width: 20, height: 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }
        .frame(width: 40, height: 42)
        .cornerRadius(8)
        .clipShape(Circle())
        .overlay {
            Circle().stroke(selected ? .green : .white, lineWidth: selected ? 1 : 0.6)
        }
    }
    
    @ViewBuilder
    private var productInfoView: some View {
        VStack(alignment: .leading) {
            Text("\(categoryName)")
                .font(.system(size: 10))
                .fontWeight(selected ? .bold : .regular)
                .foregroundColor(selected ? .green : .black)
                .multilineTextAlignment(.center)
        }
        .padding(.leading, 0)
    }
}
