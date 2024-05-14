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
    let minAmount: Int?
    let isLiked: Bool
}
