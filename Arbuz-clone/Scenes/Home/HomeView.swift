//
//  HomeView.swift
//  Arbuz-clone
//
//  Created by kakim nyssanov on 15.05.2024.
//

import SwiftUI
import URLImage

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    HeaderView(photoUrls: viewModel.headerPhotos)
                    
                    StaticCollectionView(title: viewModel.collections[0].title, products: viewModel.collections[0].products)
                    
                    HorizontalCollectionView(title: viewModel.collections[0].title, products: viewModel.collections[0].products)
                    
                }
            }
        }
    }
}

struct HeaderView: View {
    let photoUrls: [String]
    
    var body: some View {
        ScrollView(.horizontal){
            HStack(spacing: 10){
                ForEach(photoUrls, id: \.self){ photo in
                    URLImage(URL(string: photo)!){ image in
                        image
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity, maxHeight: 130)
                            .cornerRadius(10.0)
                    }
                }
            }
        }
        .cornerRadius(10.0)
        .padding()
    }
}

struct HorizontalCollectionView: View {
    let title: String
    let products: [Product]
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            Text(title)
                .font(.title)
                .padding(.horizontal)
            
            ScrollView(.horizontal){
                HStack(spacing: 20){
                    ForEach(products, id: \.id){ product in
                        ProductCardView(product: product)
                            .frame(width: 150, height: 100)
                    }
                }
            }
        }
    }
}

struct StaticCollectionView: View {
    let title: String
    let products: [Product]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            Text(title)
                .font(.title)
            
            ForEach(0..<products.count / 3) { rowIndex in
                HStack(spacing: 20){
                    ForEach(0..<3){ columnIndex in
                        let index = rowIndex * 3 + columnIndex
                        if index < products.count {
                            ProductCardView(product: products[index])
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                    }
                }
                .padding(.bottom)
            }
        }
        .padding()
    }
}

struct ProductCardView: View {
    let product: Product
    
    var body: some View {
        Text(product.name)
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
