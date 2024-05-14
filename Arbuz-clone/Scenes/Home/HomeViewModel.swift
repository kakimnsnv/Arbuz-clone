//
//  HomeViewModel.swift
//  Arbuz-clone
//
//  Created by kakim nyssanov on 15.05.2024.
//

import Foundation

class HomeViewModel: ObservableObject{
    @Published var products: [Product] = []
    @Published var collections: [(title: String, products: [Product])] = []
    @Published var headerPhotos: [String] = []
    
    init(){
        fetchProducts()
    }
    
    func fetchProducts(){
        // TODO: API.Fetch
        
        self.products = [Product(id: "1", name: "Тушка Альфур цыпленка-бройлера замороженная кг", remark: "1 шт = от 1,4 до 1,65 кг", tags: ["Курица Замороженная", "Птица", "Мясо, птица"], description: "Цыпленок бройлер - это продукт для приготовления множества блюд: супов и бульонов, вторых блюд и даже закусок. Цыпленка можно обжаривать на сковороде, запекать в духовке, готовить на гриле или мангале. А отварное мясо - лучший диетический продукт.", price: 2590, imageUrl: "https://th.bing.com/th/id/OIP.ZCmFbdN2E6-q8vN1SioPOgHaHa?rs=1&pid=ImgDetMain", minAmount: 1, isLiked: false)]
        
        self.collections = [
            (
                title: "Collection 1", products: [
                    Product(id: "1", name: "Тушка Альфур цыпленка-бройлера замороженная кг", remark: "1 шт = от 1,4 до 1,65 кг", tags: ["Курица Замороженная", "Птица", "Мясо, птица"], description: "Цыпленок бройлер - это продукт для приготовления множества блюд: супов и бульонов, вторых блюд и даже закусок. Цыпленка можно обжаривать на сковороде, запекать в духовке, готовить на гриле или мангале. А отварное мясо - лучший диетический продукт.", price: 2590, imageUrl: "https://th.bing.com/th/id/OIP.ZCmFbdN2E6-q8vN1SioPOgHaHa?rs=1&pid=ImgDetMain", minAmount: 1, isLiked: false),
                    Product(id: "2", name: "Тушка Альфур цыпленка-бройлера замороженная кг", remark: "1 шт = от 1,4 до 1,65 кг", tags: ["Курица Замороженная", "Птица", "Мясо, птица"], description: "Цыпленок бройлер - это продукт для приготовления множества блюд: супов и бульонов, вторых блюд и даже закусок. Цыпленка можно обжаривать на сковороде, запекать в духовке, готовить на гриле или мангале. А отварное мясо - лучший диетический продукт.", price: 2590, imageUrl: "https://th.bing.com/th/id/OIP.ZCmFbdN2E6-q8vN1SioPOgHaHa?rs=1&pid=ImgDetMain", minAmount: 1, isLiked: false),
                    Product(id: "3", name: "Тушка Альфур цыпленка-бройлера замороженная кг", remark: "1 шт = от 1,4 до 1,65 кг", tags: ["Курица Замороженная", "Птица", "Мясо, птица"], description: "Цыпленок бройлер - это продукт для приготовления множества блюд: супов и бульонов, вторых блюд и даже закусок. Цыпленка можно обжаривать на сковороде, запекать в духовке, готовить на гриле или мангале. А отварное мясо - лучший диетический продукт.", price: 2590, imageUrl: "https://th.bing.com/th/id/OIP.ZCmFbdN2E6-q8vN1SioPOgHaHa?rs=1&pid=ImgDetMain", minAmount: 1, isLiked: false),
                    Product(id: "4", name: "Тушка Альфур цыпленка-бройлера замороженная кг", remark: "1 шт = от 1,4 до 1,65 кг", tags: ["Курица Замороженная", "Птица", "Мясо, птица"], description: "Цыпленок бройлер - это продукт для приготовления множества блюд: супов и бульонов, вторых блюд и даже закусок. Цыпленка можно обжаривать на сковороде, запекать в духовке, готовить на гриле или мангале. А отварное мясо - лучший диетический продукт.", price: 2590, imageUrl: "https://th.bing.com/th/id/OIP.ZCmFbdN2E6-q8vN1SioPOgHaHa?rs=1&pid=ImgDetMain", minAmount: 1, isLiked: false),
                    Product(id: "5", name: "Тушка Альфур цыпленка-бройлера замороженная кг", remark: "1 шт = от 1,4 до 1,65 кг", tags: ["Курица Замороженная", "Птица", "Мясо, птица"], description: "Цыпленок бройлер - это продукт для приготовления множества блюд: супов и бульонов, вторых блюд и даже закусок. Цыпленка можно обжаривать на сковороде, запекать в духовке, готовить на гриле или мангале. А отварное мясо - лучший диетический продукт.", price: 2590, imageUrl: "https://th.bing.com/th/id/OIP.ZCmFbdN2E6-q8vN1SioPOgHaHa?rs=1&pid=ImgDetMain", minAmount: 1, isLiked: false),
                    Product(id: "6", name: "Тушка Альфур цыпленка-бройлера замороженная кг", remark: "1 шт = от 1,4 до 1,65 кг", tags: ["Курица Замороженная", "Птица", "Мясо, птица"], description: "Цыпленок бройлер - это продукт для приготовления множества блюд: супов и бульонов, вторых блюд и даже закусок. Цыпленка можно обжаривать на сковороде, запекать в духовке, готовить на гриле или мангале. А отварное мясо - лучший диетический продукт.", price: 2590, imageUrl: "https://th.bing.com/th/id/OIP.ZCmFbdN2E6-q8vN1SioPOgHaHa?rs=1&pid=ImgDetMain", minAmount: 1, isLiked: false)
                ]
            )
        ]
        
        self.headerPhotos = ["https://th.bing.com/th/id/OIP.ZCmFbdN2E6-q8vN1SioPOgHaHa?rs=1&pid=ImgDetMain", "https://th.bing.com/th/id/OIP.ZCmFbdN2E6-q8vN1SioPOgHaHa?rs=1&pid=ImgDetMain", "https://th.bing.com/th/id/OIP.ZCmFbdN2E6-q8vN1SioPOgHaHa?rs=1&pid=ImgDetMain"]
    }
}
