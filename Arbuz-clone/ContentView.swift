//
//  ContentView.swift
//  Arbuz-clone
//
//  Created by kakim nyssanov on 15.05.2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @EnvironmentObject var apiService: ApiService
    @State var activeTag = 3
    
    var body: some View {
        TabView(selection: $activeTag){
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Главная")
                }
                .tag(0)
            CartView()
                .tabItem {
                    Image(systemName: "cart")
                    Text("Корзина")
                }
                .tag(1)
            SavedView()
                .tabItem{
                    Image(systemName: "heart")
                    Text("Избранное")
                }
                .tag(2)
            AccountView()
                .tabItem{
                    Image(systemName: "person")
                    Text("Аккаунт")
                }
                .tag(3)
        }
        .accentColor(.init(red: 0, green: 0.8, blue: 0))
        .onAppear{
            activeTag = apiService.isLoggedIn() ? 0 : 3
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(ApiService.shared)
        .environmentObject(HomeViewModel())
        .environmentObject(CartViewModel())
        .environmentObject(SavedViewModel())
}
