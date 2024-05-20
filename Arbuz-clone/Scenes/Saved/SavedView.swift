//
//  SavedView.swift
//  Arbuz-clone
//
//  Created by kakim nyssanov on 18.05.2024.
//

import SwiftUI

struct SavedView: View {
    @StateObject private var viewModel = SavedViewModel()
    private var collection: Collection{
        let collections = viewModel.fetchCollection(for: nil)
        if !collections.isEmpty{
            return collections.randomElement()!
        } else {
            return Collection(id: 1, name: "Вам может понравиться ", products: [mockProduct(), mockProduct(2), mockProduct(3), mockProduct(4), mockProduct(5), mockProduct(6)])
        }
    }
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    if viewModel.likedProducts.isEmpty {
                        Spacer()
                        Text("Нет избранных продуктов")
                        Spacer()
                        HorizontalCollectionView(title: collection.name, products: collection.products)
                    } else {
                        StaticCollectionView(title: "Избранные", products: viewModel.likedProducts)
                    }
                }
                .navigationTitle(Text("Избранное"))
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .onAppear{
            viewModel.fetchSavedProducts()
        }
        .navigationViewStyle(.stack)
    }
}

#Preview {
    SavedView()
        .environmentObject(CartViewModel())
        .environmentObject(SavedViewModel())
}
