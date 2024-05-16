//
//  ContentView.swift
//  Arbuz-clone
//
//  Created by kakim nyssanov on 15.05.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Главная")
                }
            CartView()
                .tabItem {
                    Image(systemName: "cart")
                    Text("Корзина")
                }
        }
        .accentColor(.init(red: 0, green: 0.8, blue: 0))
    }
}

#Preview {
    ContentView()
        .environmentObject(HomeViewModel())
        .environmentObject(CartViewModel())
}
