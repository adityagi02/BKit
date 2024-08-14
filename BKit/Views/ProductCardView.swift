//
//  ProductCardView.swift
//  BKit
//
//  Created by Aditya Tyagi on 13/08/24.
//

import SwiftUI

// A view representing a product card with an image, name, and price.
struct ProductCardView: View {
    /// The unique identifier for the product image.
    ///
    /// This ID is used to construct the URL for fetching the product image.
    /// Example format: `https://picsum.photos/id/{id}/200/300`
    var imageID: Int
    /// The name of the product.
    var productName: String
    /// The price of the product.
    var productPrice: Double
    /// The URL for the product image, constructed using the imageID.
    private var imageURL: URL? {
        URL(string: "https://picsum.photos/id/\(imageID)/200/300")
    }

    var body: some View {
        VStack(alignment: .leading) {
            productImageView
            productInfoView
                .padding(.all, 12)
        }
        .cornerRadius(8)
        .clipShape(Rectangle())
        .overlay {
            Rectangle()
                .stroke(.black, lineWidth: 0.3)
                .cornerRadius(8)
        }
        .background(Color.white)
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
                    .frame(width: 120, height: 120)
                    .foregroundColor(.gray)
            }
            .frame(width: 150, height: 140)
            .padding(.bottom, 16)
        }
        .padding(.bottom, 8)
    }

    @ViewBuilder
    private var productInfoView: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(productName)
                .font(.headline)
                .foregroundColor(.black)
                .lineLimit(1)
                .truncationMode(.tail)
            
            Text(String(format: "$%.2f", productPrice))
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    ProductCardView(imageID: 1, productName: "Sample Product", productPrice: 4.99)
}
