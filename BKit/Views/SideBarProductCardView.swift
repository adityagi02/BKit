//
//  SideBarProductCardView.swift
//  BKit
//
//  Created by Aditya Tyagi on 13/08/24.
//

import SwiftUI

//struct SideBarCategoryCardView: View {
//    @State var selected: Bool = false
//    var imageID: Int
//    
//    private var imageURL: URL? {
//        URL(string: "https://picsum.photos/id/\(imageID)/200/300")
//    }
//    var categoryName: String
//    
//    var body: some View {
//        VStack(alignment: .center, spacing: 6) {
//            productImageView
//            productInfoView
//        }
//    }
//    
//    @ViewBuilder
//    private var productImageView: some View {
//        ZStack(alignment: .topLeading) {
//            AsyncImage(url: imageURL) { image in
//                image.resizable()
//                    .aspectRatio(contentMode: .fill)
//                
//            } placeholder: {
//                Image(systemName: "photo")
//                    .resizable()
//                    .scaledToFit()
//                    .foregroundColor(.gray)
//                    .frame(width: 20, height: 20)
//            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            
//        }
//        .frame(width: 40, height: 42)
//        .cornerRadius(8)
//        .clipShape(Circle())
//        .overlay {
//            Circle().stroke(.gray, lineWidth: 0.6)
//        }
//    }
//    
//    
//    @ViewBuilder
//    private var productInfoView: some View {
//        VStack(alignment: .leading) {
//            Text("\(categoryName)")
//                .font(.system(size: 10))
//                .foregroundColor(.black)
//                .multilineTextAlignment(.center)
//        }
//        .padding(.leading, 0)
//    }
//    
//}

//#Preview {
//    SideBarProductCardView(imageID: 1, categoryName: "Sweets & Namkeens")
//}
