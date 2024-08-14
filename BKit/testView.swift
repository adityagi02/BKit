////
////  testView.swift
////  BKit
////
////  Created by Aditya Tyagi on 13/08/24.
////
//
//import SwiftUI
//
//struct testView: View {
//    @State private var selectedSection: String = SectionTitle.food.rawValue
//    @State private var rightSectionData: [Product] = [] // Empty array to hold product data
//
//    var body: some View {
//        VStack(spacing: 0) {
//            Divider()
//
//            GeometryReader { geometry in
//                HStack(spacing: 0) {
//                    VStack {
//                        ScrollView(showsIndicators: false) {
//                            ForEach(SectionTitle.allCases, id: \.self) { section in
//                                MenuButton(title: section.rawValue, selectedSection: $selectedSection)
//                                    .onTapGesture {
//                                        // Fetch or update data for the selected section
//                                        fetchProducts(forSection: section)
//                                    }
//                            }
//                        }
//                    }
//                    .frame(width: geometry.size.width * 0.15)
//                    .background(.regularMaterial)
//
//                    Divider()
//
//                    ScrollView {
//                        RightSectionTwo(title: selectedSection, products: rightSectionData)
//                    }
//                }
//            }
//
//            Divider()
//        }
//    }
//
//    func fetchProducts(forSection: SectionTitle) {
//        // Implement your logic to fetch product data based on the selected section
//        // You can use networking, Core Data, or any other data source
//
//        // Example (replace with your actual data fetching)
//        rightSectionData = [
//            Product(id: 1, name: "Sample Product 1", price: "$4.99", image: "product_1"),
//            Product(id: 2, name: "Sample Product 2", price: "$3.99", image: "product_2"),
//            // ... add more products
//        ]
//    }
//}
//
//// Define your Product struct with relevant properties (id, name, price, image, etc.)
//struct Product: Identifiable {
//    let id: Int
//    let name: String
//    let price: String
//    let image: String // Or use an Image asset type if applicable
//}
//
//
//struct RightSectionTwo: View {
//    var title: String
//    @State private var products: [Product] = [] // Local state to store section-specific data
//
//    var body: some View {
//        VStack {
//            HStack {
//                Text(title)
//                    .font(.largeTitle)
//                    .bold()
//
//                Spacer()
//            }
//
//            ScrollView(showsIndicators: false) {
//                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 4) {
//                    ForEach(products, id: \.id) { product in
//                        ProductCardView(product: product) // Pass the product data
//                            .padding(2)
//                    }
//                }
//            }
//        }
//        .padding(.horizontal, 12)
//        .onReceive( // Observe changes in selectedSection from ContentView
//            selectedSection.publisher
//                .filter { $0 != title } // Avoid unnecessary updates for the same section
//        ) { newSection in
//            products = [] // Clear existing data before fetching new
//            fetchProducts(forSection: SectionTitle(rawValue: newSection)!) // Update data
//        }
//    }
//
//    func fetchProducts(forSection: SectionTitle) {
//        // Implement your logic to fetch product data based on the selected section (same as in ContentView)
//    }
//}
//
////struct ProductCardView: View {
////    // Implement your ProductCardView with necessary UI and logic for displaying product information
////}
//
//
//#Preview {
//    testView()
//}
