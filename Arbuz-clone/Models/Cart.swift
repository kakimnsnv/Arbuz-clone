//
//  Cart.swift
//  Arbuz-clone
//
//  Created by kakim nyssanov on 15.05.2024.
//

import Foundation

struct CartItem: Codable {
    let product: Product
    var amount: Int
}

struct Cart: Codable{
    let id: Int
    var items: [CartItem]
    
    init(){
        self.id = 0
        self.items = []
    }
    
    init(id: Int, items: [CartItem]){
        self.id = id
        self.items = items
        updateCart()
    }
    
    mutating func addItem(_ product: Product, amount: Int = 1){
        if let index = items.firstIndex(where: {$0.product.id == product.id}){
            items[index].amount += amount
        } else {
            items.append(CartItem(product: product, amount: amount))
        }
        updateCart()
    }
    
    mutating func removeItem(_ product: Product){
        if let index = items.firstIndex(where: {$0.product.id == product.id}){
            items.remove(at: index)
        }
        updateCart()
    }
    
    mutating func decrementItem(_ product: Product){
        if let index = items.firstIndex(where: {$0.product.id == product.id}){
            items[index].amount -= 1
            if items[index].amount == 0{
                items.remove(at: index)
            }
        }
        updateCart()
    }
    
    mutating func clearCart(){
        items = []
        updateCart()
    }
    
    private func updateCart(){
        ApiService.shared.putCart(self){ result in
            switch result{
            case .success(let suc):
                print("Success updating cart \(suc)")
            case .failure(let error):
                print("Error updating cart: \(error)")
            }
        }
    }
}
