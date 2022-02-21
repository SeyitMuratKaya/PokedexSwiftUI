//
//  Pokemon.swift
//  Pokedex
//
//  Created by Seyit Murat Kaya on 21.02.2022.
//

import Foundation

struct Pokemon: Hashable, Codable, Identifiable{
    var id: Int
    var name: String
}
