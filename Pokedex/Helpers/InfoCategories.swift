//
//  InfoCategories.swift
//  Pokedex
//
//  Created by Seyit Murat Kaya on 19.07.2023.
//

import Foundation

enum InfoCategories: String, CaseIterable, Identifiable {
    case about = "About"
    case stats = "Stats"
    case evolution = "Evolution"
    case moves = "Moves"
    var id: Self { self }
}
