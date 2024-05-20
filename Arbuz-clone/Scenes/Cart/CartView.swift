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
                            .padding(.bottom, 20)
                        if viewModel.cartTotal() < 8000{
                            MinAmountComponent(amount: viewModel.cartTotal())
                        }
                        
                        if ApiService.shared.isLoggedIn(){
                            CartComponent()
                                .padding(.bottom, 60)
                            
                            HorizontalCollectionView(title: viewModel.suggestionsCollection.name, products: viewModel.suggestionsCollection.products)
                        } else {
                            Text("Войдите в аккаунт")
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                }
                VStack{
                    Spacer()
                    if viewModel.cartTotal() > 8000{
                        CheckoutButton(amount: viewModel.cartTotal())
                    }
                }
            }
            .navigationTitle(Text("Корзина"))
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear{
            viewModel.fetchCart()
            viewModel.fetchCollection(for: nil)
        }
        .navigationViewStyle(.stack)
    }
}

struct MinAmountComponent: View {
    var amount: Double
    
    var body: some View {
        HStack{
            Spacer()
            Text("Заполните корзину еще на: ")
            Text("\((8000.0 - amount).formattedString()) ₸")
                .foregroundColor(.green)
            Spacer()
        }
        .font(.headline)
        .padding(.bottom)
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
        if viewModel.cartTotalItems() != 0{
            VStack(alignment: .leading){
                HStack{
                    Text("Корзина:")
                    Text("\(viewModel.cartTotalItems())")
                        .foregroundColor(.green)
                    
                    Spacer()
                    
                    Button{
                        viewModel.clearCart()
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
            .onAppear{
                viewModel.fetchCart()
            }
            .padding(.horizontal)
        } else{
            Text("Корзина пуста")
        }
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
        .environmentObject(CartViewModel())
        .environmentObject(SavedViewModel())
}
