//
//  HomeViewModel.swift
//  Arbuz-clone
//
//  Created by kakim nyssanov on 15.05.2024.
//

import Foundation

class HomeViewModel: ObservableObject{
    @Published var products: [Product] = []
    @Published var collections: [Collection] = [Collection(id: 1, name: "Вам может понравиться", products: [mockProduct(2), mockProduct(3), mockProduct(4)])]
    @Published var headerPhotos: [String] = []
    
    init(){}
    
    func fetchProducts(){
        ApiService.shared.fetchProducts{ result in
            switch result{
            case .success(let products):
                DispatchQueue.main.async {
                    self.products = products
                }
            case .failure(let error):
                print("Error while fetching products in HomeViewModel \(error)")
            }
        }
        
        ApiService.shared.fetchCollections(for: nil) { result in
            switch result{
            case .success(let collections):
                DispatchQueue.main.async {
                    self.collections = collections
                }
            case .failure(let error):
                print("Error while fetching collection in HomeViewModel \(error)")
            }
        }
        DispatchQueue.main.async {
            self.headerPhotos = ["https://arbuz.kz/image/s3/arbuz-kz-banners/d69aaf7d-dad3-48cb-bcba-2e85f19e999b-arbuz_snk_eu_footbal_apr_24_static_smm_1450x464_ru_jpg.jpg?w=1450&h=:h&c=1714626686", "https://arbuz.kz/image/s3/arbuz-kz-banners/f148ebc0-2688-4b0e-bdec-d135009cd64d-kv-rus_png.png?w=1450&h=:h&c=1715859280", "https://arbuz.kz/image/s3/arbuz-kz-banners/2e462301-4e82-4a82-aefb-81bb8e6c8548-kinder_arbuz_1450x464_2_kopiya_jpg.jpg?w=1450&h=:h&c=1715318671", "https://arbuz.kz/image/s3/arbuz-kz-banners/4d215925-e436-418a-81b3-0d348937bb6c-768_s_rus_kopiya_1_png.png?w=1450&h=:h&c=1714645508", "https://arbuz.kz/image/s3/arbuz-kz-banners/ca329d40-15d5-4124-b195-fcaf11bce059-794_s_kopiya_png.png?w=1450&h=:h&c=1713851384", "https://arbuz.kz/image/s3/arbuz-kz-banners/1f9ee786-22c1-4be3-8f29-54b3e904c7df-797_s_rus_kopiya_png.png?w=1450&h=:h&c=1715320282", "https://arbuz.kz/image/s3/arbuz-kz-banners/c8d7853d-e295-4614-b78f-1a0b10065cf4-1450h464_jpg.jpg?w=1450&h=:h&c=1716188254"]
        }
    }
}
