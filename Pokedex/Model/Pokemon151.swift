//
//  Pokemon151.swift
//  Pokedex
//
//  Created by Seyit Murat Kaya on 21.02.2022.
//

import Foundation

struct Pokemon151:Codable{
    var results: [Result]
}

struct Result:Codable{
    var name:String
    var url:String
}
