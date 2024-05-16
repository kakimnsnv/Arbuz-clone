//
//  CartViewModel.swift
//  Arbuz-clone
//
//  Created by kakim nyssanov on 15.05.2024.
//

import Foundation

class CartViewModel: ObservableObject{
    @Published var cart: Cart = Cart(items: [])
    @Published var suggestionsCollections: [(title: String, products: [Product])] = []
    
    init(){
        fetchCart()
    }
    
    func fetchCart(){
        // TODO: Api fetch
        
        
        self.cart.items = [
            CartItem(product: Product(id: "1", name: "Тушка Альфур цыпленка-бройлера замороженная кг", remark: "1 шт = от 1,4 до 1,65 кг", tags: ["Курица Замороженная", "Птица", "Мясо, птица"], description: "Цыпленок бройлер - это продукт для приготовления множества блюд: супов и бульонов, вторых блюд и даже закусок. Цыпленка можно обжаривать на сковороде, запекать в духовке, готовить на гриле или мангале. А отварное мясо - лучший диетический продукт.", price: 2590, imageUrl: "https://th.bing.com/th/id/OIP.ZCmFbdN2E6-q8vN1SioPOgHaHa?rs=1&pid=ImgDetMain", minAmount: 1, amountType: "кг", isLiked: false), amount: 1)
        ]
        
        self.suggestionsCollections = [
            (
                title: "Вам может понравиться", products: [
                    Product(id: "1", name: "Тушка Альфур цыпленка-бройлера замороженная кг", remark: "1 шт = от 1,4 до 1,65 кг", tags: ["Курица Замороженная", "Птица", "Мясо, птица"], description: "Цыпленок бройлер - это продукт для приготовления множества блюд: супов и бульонов, вторых блюд и даже закусок. Цыпленка можно обжаривать на сковороде, запекать в духовке, готовить на гриле или мангале. А отварное мясо - лучший диетический продукт.", price: 2590, imageUrl: "https://th.bing.com/th/id/OIP.ZCmFbdN2E6-q8vN1SioPOgHaHa?rs=1&pid=ImgDetMain", minAmount: 1, amountType: "кг", isLiked: false),
                    Product(id: "2", name: "Тушка Альфур цыпленка-бройлера замороженная кг", remark: "1 шт = от 1,4 до 1,65 кг", tags: ["Курица Замороженная", "Птица", "Мясо, птица"], description: "Цыпленок бройлер - это продукт для приготовления множества блюд: супов и бульонов, вторых блюд и даже закусок. Цыпленка можно обжаривать на сковороде, запекать в духовке, готовить на гриле или мангале. А отварное мясо - лучший диетический продукт.", price: 2590, imageUrl: "https://th.bing.com/th/id/OIP.ZCmFbdN2E6-q8vN1SioPOgHaHa?rs=1&pid=ImgDetMain", minAmount: 1, amountType: "кг", isLiked: false),
                    Product(id: "3", name: "Тушка Альфур цыпленка-бройлера замороженная кг", remark: "1 шт = от 1,4 до 1,65 кг", tags: ["Курица Замороженная", "Птица", "Мясо, птица"], description: "Цыпленок бройлер - это продукт для приготовления множества блюд: супов и бульонов, вторых блюд и даже закусок. Цыпленка можно обжаривать на сковороде, запекать в духовке, готовить на гриле или мангале. А отварное мясо - лучший диетический продукт.", price: 2590, imageUrl: "https://th.bing.com/th/id/OIP.ZCmFbdN2E6-q8vN1SioPOgHaHa?rs=1&pid=ImgDetMain", minAmount: 1, amountType: "кг", isLiked: false),
                ]
            ),
        ]
        
        
    }
}
