//
//  Pokemon151.swift
//  Pokedex
//
//  Created by Seyit Murat Kaya on 21.02.2022.
//

import Foundation

struct Pokemon:Codable, Hashable{
    let id: Int
    let name: String
    let types: [PType]
    let height: Int
    let weight: Int
    let stats: [Stat]
    let moves: [Move]
}

struct PType: Codable, Hashable {
    let slot: Int
    let type: Species
}

struct Species: Codable, Hashable {
    let name: String
    let url: String
}

struct Stat: Codable, Hashable {
    let baseStat: Int
    let effort: Int
    let stat: Species
}

struct Move: Codable, Hashable {
    let move: Species
}
