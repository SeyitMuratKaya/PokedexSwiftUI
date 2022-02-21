//
//  PokemonData.swift
//  Pokedex
//
//  Created by Seyit Murat Kaya on 18.02.2022.
//

import Foundation

struct Pokemons:Codable{
    var results: [Pokemon]
}
struct Pokemon:Codable,Identifiable{
    var id:String{
        return url
    }
    var name:String
    var url:String
}
