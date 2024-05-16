//
//  Product.swift
//  Arbuz-clone
//
//  Created by kakim nyssanov on 15.05.2024.
//

import Foundation

struct Product {
    let id: String
    let name: String
    let remark: String?
    let tags: [String]?
    let description: String?
    let price: Double
    let imageUrl: String
    let minAmount: Double
    let amountType: String
    let isLiked: Bool
}

extension Double {
    func formattedString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 2
        
        let formattedNumber = NSNumber(value: self)
        let formattedString = numberFormatter.string(from: formattedNumber) ?? ""
        
        return formattedString
    }
}
