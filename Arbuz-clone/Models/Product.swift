//
//  Product.swift
//  Arbuz-clone
//
//  Created by kakim nyssanov on 15.05.2024.
//

import Foundation

struct Product: Identifiable, Codable {
    let id: String
    let name: String
    let remark: String?
    let tags: [String]?
    let description: String?
    let price: Double
    let imageUrl: String
    let minAmount: Double
    let amountType: String
    var isLiked: Bool
    
    mutating func toggleLike(){
        self.isLiked.toggle()
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, remark, tags, description, price, imageUrl, minAmount, amountType, isLiked
    }
    
    init(id: String, name: String, remark: String?, tags: [String]?, description: String?, price: Double, imageUrl: String, minAmount: Double, amountType: String, isLiked: Bool) {
        self.id = id
        self.name = name
        self.remark = remark
        self.tags = tags
        self.description = description
        self.price = price
        self.imageUrl = imageUrl
        self.minAmount = minAmount
        self.amountType = amountType
        self.isLiked = isLiked
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        remark = try container.decodeIfPresent(String.self, forKey: .remark)
        tags = try container.decodeIfPresent([String].self, forKey: .tags)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        
        // Decode price as a String and convert to Double
        let priceString = try container.decode(String.self, forKey: .price)
        price = Double(priceString) ?? 0.0
        
        imageUrl = try container.decode(String.self, forKey: .imageUrl)
        
        // Decode minAmount as a String and convert to Double
        let minAmountString = try container.decode(String.self, forKey: .minAmount)
        minAmount = Double(minAmountString) ?? 0.0
        
        amountType = try container.decode(String.self, forKey: .amountType)
        isLiked = try container.decode(Bool.self, forKey: .isLiked)
    }
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
