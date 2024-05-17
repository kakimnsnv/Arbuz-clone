//
//  ProductCardView.swift
//  Arbuz-clone
//
//  Created by kakim nyssanov on 16.05.2024.
//

import SwiftUI
import URLImage

struct ProductCardView: View {
    @State var isSheetOpen: Bool = false
    @EnvironmentObject var cartViewModel: CartViewModel
    
    let product: Product

    var counter: Double{
        return Double(cartViewModel.cart.items.first(where: {$0.product.id == product.id})?.amount ?? 0)
    }
    
    var body: some View {
        VStack(alignment: .leading){
            ZStack{
                if let url = URL(string: product.imageUrl) {
                    URLImage(url){ image in
                        image
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                    }
                    .onTapGesture {
                        isSheetOpen.toggle()
                    }
                }
                VStack{
                    HStack{
                        Spacer()
                        LikeButton(product: product)
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
                if counter != 0 {
                    Text("\((product.price * counter).formattedString()) ₸")
                } else {
                    Text("\(product.price.formattedString()) ₸/\(product.amountType) ")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                    Text("· \(product.minAmount.formattedString())\(product.amountType)")
                        .font(.caption)
                        .foregroundColor(.green)
                        .lineLimit(1)
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
        .sheet(isPresented: $isSheetOpen){
            ProductSheetView(collection: (title: "String", products: [mockProduct(2), mockProduct(2)]), product: product)
        }
    }
}

struct LikeButton: View {
    var product: Product
    
    var body: some View {
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

struct HorizontalCollectionView: View {
    let title: String
    let products: [Product]
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            Text(title)
                .font(.title)
                .padding()
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: 5){
                    ForEach(products, id: \.id){ product in
                        ProductCardView(product: product)
                            .frame(maxWidth: 150, maxHeight: 200)
                    }
                }
                .padding(.horizontal)
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
                .padding(.bottom)
            
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

struct CartItemView: View {
    var item: CartItem
    @State var isSheetOpen: Bool = false
    @EnvironmentObject var viewModel: CartViewModel
    
    var body: some View {
        HStack{
            if let url = URL(string: item.product.imageUrl) {
                URLImage(url){ image in
                    image
                        .resizable()
                        .frame(width: 100, height: 100)
                        .aspectRatio(1, contentMode: .fit)
                        .cornerRadius(13.0)
                }
                .onTapGesture {
                    isSheetOpen.toggle()
                }
            }
            VStack{
                HStack{
                    Text(item.product.name)
                    Spacer()
                    Button{
                        viewModel.cart.removeItem(item.product)
                    }label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                    }
                }
                Spacer()
                HStack{
                    AmountButton(item: item, cart: $viewModel.cart)
                    Spacer()
                    Text("\((Double(item.amount) * item.product.price).formattedString()) ₸")
                }
            }
        }
        .sheet(isPresented: $isSheetOpen){
            ProductSheetView(collection: (title: "String", products: [mockProduct(), mockProduct(2)]), product: item.product)
        }
    }
}

struct AmountButton: View {
    var item: CartItem
    @Binding var cart: Cart
    
    var body: some View {
        HStack{
            if(item.amount == 1){
                Button{
                    cart.removeItem(item.product)
                } label: {
                    Image(systemName: "trash.fill")
                }
            } else {
                Button{
                    cart.decrementItem(item.product)
                } label: {
                    Image(systemName: "minus")
                }
            }
            
            Text("\((Double(item.amount) * item.product.minAmount).formattedString()) \(item.product.amountType)")
                .padding(.horizontal, 10)
            
            Button{
                cart.addItem(item.product)
            } label: {
                Image(systemName: "plus")
            }
        }
        .padding(5)
        .foregroundColor(.black.opacity(0.8))
        .background(
            RoundedRectangle(cornerRadius: 50.0)
                .fill(.gray.opacity(0.2))
        )
    }
}

struct ProductSheetView: View {
    @EnvironmentObject var cartViewModel: CartViewModel
    var collection: (title: String, products: [Product])
    var product: Product
    
    var body: some View {
        ZStack{
            ScrollView{
                VStack{
                    VStack{
                        TopButtons(product: product)
                        
                        if let url = URL(string: product.imageUrl){
                            URLImage(url){ image in
                                image
                                    .resizable()
                                    .aspectRatio(1, contentMode: .fit)
                                    .frame(width: .infinity)
                            }
                        }
                        
                        Text(product.name)
                            .font(.title3.bold())
                            .multilineTextAlignment(.center)
                        
                        Text("\(product.price.formattedString()) ₸/\(product.amountType)")
                            .foregroundColor(.secondary)
                        
                        Tags(product: product)
                    }
                    .padding(.bottom)
                    
                    DescriptionView(product: product)
                    
                    CollectionView(collection: collection)
                }
                .background(
                    Rectangle()
                        .fill(Color(red: 0.95, green: 0.95, blue: 0.95))
                )
            }
            
            VStack{
                Spacer()
                BuyButton(product: product)
            }
            .ignoresSafeArea(edges: .bottom)
            .frame(maxWidth: .infinity)
        }
    }
}

private struct BuyButton: View {
    var product: Product
    @EnvironmentObject var cartViewModel: CartViewModel
    
    var counter: Double{
        return Double(cartViewModel.cart.items.first(where: {$0.product.id == product.id})?.amount ?? 0)
    }
    
    var body: some View {
        if cartViewModel.cart.items.contains(where: {$0.product.id != product.id}){
            Button{
                cartViewModel.cart.addItem(product)
            } label: {
                HStack{
                    VStack{
                        Text("\(product.price.formattedString()) ₸")
                            .font(.title3.bold())
                        Text("за \(product.minAmount.formattedString()) \(product.amountType)")
                            .font(.footnote)
                    }
                    
                    Image(systemName: "plus")
                        .font(.title3.bold())
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green)
            }
        } else {
            HStack{
                Button{
                    cartViewModel.cart.decrementItem(product)
                }label: {
                    Image(systemName: "minus")
                        .font(.title3.bold())
                }
                .padding(.horizontal)
                
                Spacer()
                
                VStack{
                    Text("\((product.price * counter).formattedString()) ₸")
                        .font(.title3.bold())
                    Text("\((product.minAmount * Double(cartViewModel.cart.items.first(where: {$0.product.id == product.id})?.amount ?? 1)).formattedString()) \(product.amountType)")
                        .font(.footnote)
                }
                
                Spacer()
                
                Button{
                    cartViewModel.cart.addItem(product)
                }label: {
                    Image(systemName: "plus")
                        .font(.title3.bold())
                }
                .padding(.horizontal)
                
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.green)
        }
    }
}

private struct Tags: View {
    var product: Product
    
    var body: some View {
        if product.tags != nil{
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach(product.tags!, id: \.self){ tag in
                        Text(tag)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(
                                RoundedRectangle(cornerRadius:10.0)
                                    .fill(.white)
                            )
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

private struct TopButtons: View {
    var product: Product
    
    var body: some View {
        HStack{
            Spacer()
            Button{
                // TODO: share link
                let contentToShare = "\(product.name) - \(product.price) ₸. Arbuz.kz"
                let activityViewController = UIActivityViewController(activityItems: [contentToShare], applicationActivities: nil)
                UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
            }label: {
                Image(systemName: "square.and.arrow.up")
            }
            LikeButton(product: product)
        }
        .foregroundColor(.primary)
    }
}

private struct CollectionView: View {
    var collection: (title: String, products: [Product])
    
    var body: some View {
        VStack(alignment: .leading){
            HorizontalCollectionView(title: collection.title, products: collection.products)
                .padding(.bottom)
        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color.white)
        )
        .padding(.bottom, 50)
    }
}

private struct DescriptionView: View {
    var product: Product
    var body: some View {
        VStack(alignment: .leading){
            Text("Описание")
                .font(.headline)
                .padding(.vertical)
            
            Text(product.description ?? "")
                .font(.body)
                .foregroundColor(.black.opacity(0.8))
                .padding(.bottom)
            
        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color.white)
        )
    }
}

#Preview {
    ProductSheetView(collection: (title: "Похожие товары", products: [mockProduct(), mockProduct(), mockProduct(), mockProduct()]), product: mockProduct())
        .environmentObject(CartViewModel())
}

#Preview{
    CartItemView(item: CartItem(product: mockProduct(), amount: 1))
        .environmentObject(CartViewModel())
        .frame(width: .infinity, height: 100)
}

#Preview{
    HorizontalCollectionView(title: "Horizontal Collection", products: [mockProduct(),mockProduct(2),mockProduct(3),mockProduct(4),])
    .environmentObject(CartViewModel())
}


#Preview{
    StaticCollectionView(title: "Static Collection", products: [mockProduct(),mockProduct(2),mockProduct(3),mockProduct(4),mockProduct(5),mockProduct(6),])
        .environmentObject(CartViewModel())
}

#Preview {
    ProductCardView(product: mockProduct())
        .environmentObject(CartViewModel())
}
