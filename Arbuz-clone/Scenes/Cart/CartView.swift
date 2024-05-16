//
//  CartView.swift
//  Arbuz-clone
//
//  Created by kakim nyssanov on 15.05.2024.
//

import SwiftUI
import URLImage

struct CartView: View {
    @EnvironmentObject var viewModel: CartViewModel
    
    var body: some View {
        NavigationView{
            ZStack{
                ScrollView{
                    VStack(alignment: .leading, spacing: 0){
                        AddressComponent()
                            .padding(.bottom, 30)
                        
                        CartComponent()
                            .padding(.bottom, 60)
                        
                        HorizontalCollectionView(title: viewModel.suggestionsCollections[0].title, products: viewModel.suggestionsCollections[0].products)
                    }
                }
                VStack{
                    Spacer()
                    CheckoutButton(amount: viewModel.cart.total)
                }
            }
            .navigationTitle(Text("Корзина"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct AddressComponent: View {
    var body: some View {
        HStack{
            Spacer()
            
            HStack{
                Image(systemName: "location")
                VStack{
                    Text("Алматы, Сегодня, 18:00-20:00")
                    Text("Укажите адрес доставки")
                        .foregroundColor(.secondary)
                }
            }
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.secondary, lineWidth: 1)
            )
            
            Spacer()
        }
    }
}

struct CartComponent: View {
    @EnvironmentObject var viewModel: CartViewModel
    
    var body: some View {
        if viewModel.cart.totalItems != 0{
            VStack(alignment: .leading){
                HStack{
                    Text("Корзина:")
                    Text("\(viewModel.cart.totalItems)")
                        .foregroundColor(.green)
                    
                    Spacer()
                    
                    Button{
                        viewModel.cart.clearCart()
                    } label: {
                        Text("Очитить корзину")
                            .foregroundColor(.secondary)
                            .font(.subheadline)
                    }
                }
                .font(.title2.bold())
                
                Text("Товары")
                
                ForEach(viewModel.cart.items, id: \.product.id){ item in
                    CartItemView(item: item)
                }
                
            }
            .padding(.horizontal)
        } else{
            Text("Корзина пуста")
        }
    }
}

struct CartItemView: View {
    var item: CartItem
    @EnvironmentObject var viewModel: CartViewModel
    
    var body: some View {
        HStack{
            URLImage(URL(string: item.product.imageUrl) ?? URL(string: "https://th.bing.com/th/id/OIP.ZCmFbdN2E6-q8vN1SioPOgHaHa?rs=1&pid=ImgDetMain")!){ image in
                image
                    .resizable()
                    .frame(width: 100, height: 100)
                    .aspectRatio(1, contentMode: .fit)
                    .cornerRadius(13.0)
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
                .fill(Color.gray.opacity(0.3))
        )
    }
}


struct CheckoutButton: View {
    let amount: Double
    
    var body: some View {
        NavigationLink(destination: CheckoutView()){
            VStack{
                Text("Go to checkout!")
                Text("\(Int(amount)) ₸")
            }
        }
        .padding(.horizontal, 30)
        .padding(.all, 5)
        .foregroundColor(.white)
        .background(Color.green.opacity(0.9))
        .cornerRadius(30.0)
        
    }
}

struct CheckoutView: View {
    var body: some View {
        Text("Hello, World!")
    }
}


#Preview {
    CartView()
}
