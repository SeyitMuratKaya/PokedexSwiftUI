//
//  BaseType.swift
//  Pokedex
//
//  Created by Seyit Murat Kaya on 22.07.2023.
//

import Foundation

struct BaseType {
    var name: String
    var offense: [TypeWithEffect]
    var defense: [TypeWithEffect]
}

struct TypeWithEffect: Identifiable {
    let id = UUID().uuidString
    var name: String
    var effectValue: Double
}
