//
//  ChainElement.swift
//  Pokedex
//
//  Created by Seyit Murat Kaya on 19.07.2023.
//

import Foundation

struct ChainElement: Hashable {
    var fromPokemon: Pokemon?
    var minLevel: Int
    var toPokemon: Pokemon?
}
