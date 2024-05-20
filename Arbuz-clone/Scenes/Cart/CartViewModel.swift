//
//  CartViewModel.swift
//  Arbuz-clone
//
//  Created by kakim nyssanov on 15.05.2024.
//

import Foundation

class CartViewModel: ObservableObject{
    @Published var cart: Cart = Cart()
    @Published var suggestionsCollection: Collection = Collection(id: 1, name: "Вам может понравиться", products: [mockProduct(2), mockProduct(3), mockProduct(4)])
    
    func fetchCart(){
        if ApiService.shared.isLoggedIn(){
            ApiService.shared.fetchCart{ result in
                switch result {
                case .success(let cart):
                    DispatchQueue.main.async {
                        self.cart = cart
                    }
                case .failure(let error):
                    print("Error while fetchin cart in CartViewModel \(error)")
                }
            }
        }
    }
    
    func putCart(for cart: Cart) {
        let c = Cart(id: cart.id, items: cart.items)
        
        ApiService.shared.putCart(c) { result in
            switch result {
            case .success:
                self.fetchCart()
            case .failure(let error):
                print("Error updating cart: \(error)")
            }
        }
    }
    
    func cartTotalItems() -> Int{
        return cart.items.reduce(0) { $0 + $1.amount}
    }
    
    func cartTotal() -> Double{
        return cart.items.reduce(0.0) { $0 + Double($1.amount) * Double($1.product.price) }
    }
    
    func clearCart(){
        let c = Cart(id: cart.id, items: [])
        
        ApiService.shared.putCart(c) { result in
            switch result {
            case .success:
                self.fetchCart()
            case .failure(let error):
                print("Error clearing cart: \(error)")
            }
        }
    }
    
    func fetchCollection(for product: Product?){
        if ApiService.shared.isLoggedIn(){
            ApiService.shared.fetchCollections(for: product){ result in
                switch result {
                case .success(let collections):
                    DispatchQueue.main.async {
                        self.suggestionsCollection = collections.randomElement()!
                    }
                case .failure(let error):
                    print("Error fetching collection in CartViewModel \(error)")
                }
            }
        }
    }
}
