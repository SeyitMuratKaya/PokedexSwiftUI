//
//  TypeDetails.swift
//  Pokedex
//
//  Created by Seyit Murat Kaya on 20.07.2023.
//

import Foundation

struct TypeDetails: Codable {
    let name: String
    let id: Int
    let damageRelations: Relations
}

struct Relations: Codable {
    let doubleDamageFrom: [Species]?
    let doubleDamageTo: [Species]?
    let halfDamageFrom: [Species]?
    let halfDamageTo: [Species]?
    let noDamageFrom: [Species]?
    let noDamageTo: [Species]?
}
