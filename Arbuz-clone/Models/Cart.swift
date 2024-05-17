//
//  Cart.swift
//  Arbuz-clone
//
//  Created by kakim nyssanov on 15.05.2024.
//

import Foundation

struct CartItem {
    let product: Product
    var amount: Int
}

struct Cart{
    var items: [CartItem]
    
    mutating func addItem(_ product: Product, amount: Int = 1){
        if let index = items.firstIndex(where: {$0.product.id == product.id}){
            items[index].amount += amount
        } else {
            items.append(CartItem(product: product, amount: amount))
        }
    }
    
    mutating func removeItem(_ product: Product){
        if let index = items.firstIndex(where: {$0.product.id == product.id}){
            items.remove(at: index)
        }
    }
    
    mutating func decrementItem(_ product: Product){
        if let index = items.firstIndex(where: {$0.product.id == product.id}){
            items[index].amount -= 1
            if items[index].amount == 0{
                items.remove(at: index)
            }
        }
    }
    
    mutating func clearCart(){
        items = []
    }
    
    var total: Double {
        return items.reduce(0.0) { $0 + Double($1.amount) * Double($1.product.price) }
    }
    
    var totalItems: Int {
        return items.reduce(0) { $0 + $1.amount}
    }
}
