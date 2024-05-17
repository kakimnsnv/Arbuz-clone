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

func mockProduct(_ id: Int = 1) -> Product{
    return Product(id: "\(id)", name: "Тушка Альфур цыпленка-бройлера замороженная кг", remark: "1 шт = от 1,4 до 1,65 кг", tags: ["Курица Замороженная", "Птица", "Мясо, птица"], description: "Цыпленок бройлер - это продукт для приготовления множества блюд: супов и бульонов, вторых блюд и даже закусок. Цыпленка можно обжаривать на сковороде, запекать в духовке, готовить на гриле или мангале. А отварное мясо - лучший диетический продукт.", price: 2590, imageUrl: "https://th.bing.com/th/id/OIP.ZCmFbdN2E6-q8vN1SioPOgHaHa?rs=1&pid=ImgDetMain", minAmount: 1.0, amountType: "кг", isLiked: false)
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
