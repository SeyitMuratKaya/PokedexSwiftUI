//
//  Pokemon.swift
//  Pokedex
//
//  Created by Seyit Murat Kaya on 21.02.2022.
//

import Foundation

struct Pokemon:Codable,Identifiable{
    var id:Int
    var name:String
    var types: [SingleType]
}

struct SingleType:Codable{
    var type: TypeName
}

struct TypeName:Codable{
    var name:String?
}
