//
//  SavedViewModel.swift
//  Arbuz-clone
//
//  Created by kakim nyssanov on 17.05.2024.
//

import Foundation
import Combine

class SavedViewModel: ObservableObject {
    @Published var likedProducts: [Product] = []
    
    init(){}

    func fetchSavedProducts() {
        ApiService.shared.fetchProducts { result in
            switch result {
            case .success(let products):
                DispatchQueue.main.async {
                    self.likedProducts = products.filter { $0.isLiked }
                }
            case .failure(let error):
                print("Error fetching products: \(error)")
            }
        }
    }

    func toggleLike(for product: Product) {
        let p = Product(id: product.id, name: product.name, remark: product.remark, tags: product.tags, description: product.description, price: product.price, imageUrl: product.imageUrl, minAmount: product.minAmount, amountType: product.amountType, isLiked: !product.isLiked)
        
        ApiService.shared.putProduct(p) { result in
            switch result {
            case .success:
                self.fetchSavedProducts()
            case .failure(let error):
                print("Error updating product: \(error)")
            }
        }
    }
    
    func fetchCollection(for product: Product?) -> [Collection]{
        var collections: [Collection] = []
        
        ApiService.shared.fetchCollections(for: product){ result in
            switch result {
            case .success(let colllections):
                collections = colllections
            case .failure(let error):
                collections = [Collection(id: 1, name: "Вам может понравиться", products: [mockProduct(2), mockProduct(3)])]
                print("Error fetching collection in SavedViewModel \(error)")
            }
        }
        return collections
    }

    func isProductLiked(_ product: Product) -> Bool {
        return likedProducts.contains(where: { $0.id == product.id })
    }
}

