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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(homeViewModel)
                .environmentObject(cartViewModel)
        }
    }
}
