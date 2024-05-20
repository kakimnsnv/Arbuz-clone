//
//  Arbuz_cloneApp.swift
//  Arbuz-clone
//
//  Created by kakim nyssanov on 15.05.2024.
//

import SwiftUI

@main
struct Arbuz_cloneApp: App {
    @StateObject var cartViewModel: CartViewModel = CartViewModel()
    @StateObject var homeViewModel: HomeViewModel = HomeViewModel()
    @StateObject var apiService: ApiService = ApiService.shared
    @StateObject var savedViewModel: SavedViewModel = SavedViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(apiService)
                .environmentObject(homeViewModel)
                .environmentObject(cartViewModel)
                .environmentObject(savedViewModel)
        }
    }
}
