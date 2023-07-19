//
//  ChainElement.swift
//  Pokedex
//
//  Created by Seyit Murat Kaya on 19.07.2023.
//

import Foundation

struct ChainElement: Hashable {
    var from: String?
    var fromUrl: String?
    var minLevel: Int
    var to: String?
    var toUrl: String?
}
