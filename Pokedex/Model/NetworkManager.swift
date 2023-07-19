//
//  NetworkManager.swift
//  Pokedex
//
//  Created by Seyit Murat Kaya on 18.02.2022.
//

import Foundation

class PokemonAPI {
    private static let endpoint = "https://pokeapi.co/api/v2/pokemon/"
    private static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    static func fetchPokemon(withId id: Int) async throws -> Pokemon {
        guard let url = URL(string: endpoint + "\(id)") else {
            throw PokeError.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw PokeError.invalidResponse
        }
        
        do {
            let pokemon = try decoder.decode(Pokemon.self, from: data)
            return pokemon
        } catch {
            throw PokeError.invalidData
        }
    }
    
    static func fetchPokemons(from: Int, to: Int) async throws -> [Pokemon] {
        return try await withThrowingTaskGroup(of: Pokemon.self) { group in
            var pokemons: [Pokemon] = []
            for id in from...to {
                group.addTask {
                    try await fetchPokemon(withId: id)
                }
            }
            
            for try await pokemon in group {
                pokemons.append(pokemon)
            }
            
            return pokemons
        }
    }
}
