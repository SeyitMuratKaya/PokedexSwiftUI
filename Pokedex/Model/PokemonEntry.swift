//
//  PokemonEntry.swift
//  Pokedex
//
//  Created by Seyit Murat Kaya on 22.02.2022.
//

import Foundation

struct PokemonEntry: Codable {
    let flavorTextEntries: [FlavorTextEntry]

    enum CodingKeys: String, CodingKey {
        case flavorTextEntries = "flavor_text_entries"
    }
}

struct FlavorTextEntry: Codable {
    let flavorText: String

    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
    }
}
