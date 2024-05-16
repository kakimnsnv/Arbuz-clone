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
    @ObservedObject var cartViewModel: CartViewModel
    
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
                HStack(spacing: 5){
                    ForEach(products, id: \.id){ product in
                        ProductCardView(product: product)
                            .frame(maxWidth: 150, maxHeight: 200)
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
                HStack(spacing: 10){
                    ForEach(0..<3){ columnIndex in
                        let index = rowIndex * 3 + columnIndex
                        if index < products.count {
                            ProductCardView(product: products[index])
                                .frame(maxHeight: 200)
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
    
    var counter: Double = 0
    
    var body: some View {
        VStack(alignment: .leading){
            ZStack{
                URLImage(URL(string: product.imageUrl) ?? URL(string: "https://th.bing.com/th/id/OIP.ZCmFbdN2E6-q8vN1SioPOgHaHa?rs=1&pid=ImgDetMain")!){ image in
                    image
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                }
                VStack{
                    HStack{
                        Spacer()
                        Button{
                            // TODO: add to cart and like
                        } label: {
                            if product.isLiked {
                                Image(systemName: "heart.fill")
                                    .foregroundColor(.red)
                            } else {
                                Image(systemName: "heart")
                                    .foregroundColor(.black)
                            }
                        }
                        .padding(5)
                    }
                    Spacer()
                    if product.tags != nil{
                        ForEach(product.tags!, id: \.self){ tag in
                            HStack{
                                Text(tag)
                                    .font(.caption2)
                                    .padding(.horizontal, 7)
                                    .background(
                                        Rectangle()
                                            .fill(Color(red: Double.random(in: 0.3..<1), green: Double.random(in: 0.4..<1), blue: Double.random(in: 0.1..<1)))
                                            .clipShape(RoundedCornerShape(cornerRadius: 10, corners: [.topRight, .bottomRight]))
                                    )
                                Spacer()
                            }
                        }
                    }
                }
            }
            .cornerRadius(10.0)
            
            Text(product.name)
                .font(.caption)
                .lineLimit(2)
            
            HStack(spacing: 0){
                if counter == 0 {
                    Text("\(product.price.formattedString()) ₸/\(product.amountType) ")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                    Text("· \(product.minAmount.formattedString())\(product.amountType)")
                        .font(.caption)
                        .foregroundColor(.green)
                        .lineLimit(1)
                } else {
                    Text("\(counter * product.price) ₸")
                }
            }
            
            if counter == 0 {
                Button{
                    
                } label: {
                    HStack{
                        Text("\(product.price.formattedString())₸")
                            .foregroundColor(.black.opacity(0.9))
                            .fontWeight(.bold)
                            .lineLimit(1)
                        
                        
                        Image(systemName: "plus")
                            .foregroundColor(.green)
                            .padding(.leading, 5)
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(.gray.opacity(0.2))
                    )
                }
            } else {
                HStack{
                    Button{
                        
                    } label: {
                        Image(systemName: "minus")
                            .font(.headline.bold())
                    }
                    
                    VStack(spacing: 0){
                        Text("\((product.minAmount * counter).formattedString())")
                            .fontWeight(.bold)
                        Text(product.amountType)
                            .font(.caption2.italic().bold())
                    }
                    .padding(.horizontal, 5)
                    
                    Button{
                        
                    } label: {
                        Image(systemName: "plus")
                            .font(.headline.bold())
                    }
                }
                .padding(.horizontal, 10)
                .foregroundColor(.white)
                .background(
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(Color(red: 0, green: 0.8, blue: 0))
                )
            }
        }
    }
}

struct RoundedCornerShape: Shape {
    var cornerRadius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
        )
        return Path(path.cgPath)
    }
}


#Preview {
    HomeView(viewModel: HomeViewModel(), cartViewModel: CartViewModel())
}
