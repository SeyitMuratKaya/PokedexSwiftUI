//
//  Moves.swift
//  Pokedex
//
//  Created by Seyit Murat Kaya on 18.07.2023.
//

import Foundation

struct MoveDetail: Codable {
    let id: Int
    let accuracy: Int?
    let power: Int?
    let pp: Int
    let name: String
    let type: Species
    let damageClass: Species
}
