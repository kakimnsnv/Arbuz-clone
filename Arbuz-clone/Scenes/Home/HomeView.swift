//
//  HomeView.swift
//  Arbuz-clone
//
//  Created by kakim nyssanov on 15.05.2024.
//

import SwiftUI
import URLImage

struct HomeView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    @EnvironmentObject var cartViewModel: CartViewModel
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    HeaderView(photoUrls: viewModel.headerPhotos)
                    
                    StaticCollectionView(title: viewModel.collections[0].title, products: viewModel.collections[0].products)
                    
                    HorizontalCollectionView(title: viewModel.collections[0].title, products: viewModel.collections[0].products)
                    
                }
            }
            .navigationTitle(Text("Arbuz.kz"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct HeaderView: View {
    let photoUrls: [String]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 0){
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


#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
        .environmentObject(CartViewModel())
}
