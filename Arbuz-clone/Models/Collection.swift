//
//  Collection.swift
//  Arbuz-clone
//
//  Created by kakim nyssanov on 19.05.2024.
//

import Foundation

struct Collection: Codable, Identifiable{
    var id: Int
    var name: String
    var products: [Product]
}
