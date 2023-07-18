//
//  EvolutionModel.swift
//  Pokedex
//
//  Created by Seyit Murat Kaya on 17.07.2023.
//

import Foundation

// MARK: - EvolutionModel
struct EvolutionModel: Codable {
    let chain: Chain
    let id: Int
}

// MARK: - Chain
struct Chain: Codable {
    let evolutionDetails: [EvolutionDetail]
    let evolvesTo: [Chain]
    let species: Species
}

// MARK: - EvolutionDetail
struct EvolutionDetail: Codable {
    let minLevel: Int
}
