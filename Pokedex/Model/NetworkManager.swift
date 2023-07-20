//
//  NetworkManager.swift
//  Pokedex
//
//  Created by Seyit Murat Kaya on 18.02.2022.
//

import Foundation

class PokemonAPI {
    private static let endpoint = "https://pokeapi.co/api/v2/"
    private static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    static func fetchPokemon(withId id: Int) async throws -> Pokemon {

        guard let url = URL(string: endpoint + "pokemon/\(id)") else {
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
    
    static func fetchPokemon(withName name: String) async throws -> Pokemon {
        
        guard let url = URL(string: endpoint + "pokemon/\(name)") else {
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
    
    static func fetchPokemonSpecies(withId id: Int) async throws -> PokemonSpecies{
        guard let url = URL(string: endpoint + "pokemon-species/\(id)") else {
            throw PokeError.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw PokeError.invalidResponse
        }
        
        do {
            let pokemonSpecies = try decoder.decode(PokemonSpecies.self, from: data)
            return pokemonSpecies
        }catch {
            throw PokeError.invalidData
        }
    }
    
    static func fetchEvolutionChain(fromUrl url: String) async throws -> EvolutionModel {
        let endpoint = url
        
        guard let url = URL(string: endpoint) else {
            throw PokeError.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw PokeError.invalidResponse
        }
        
        do {
            let evolutionChain = try decoder.decode(EvolutionModel.self, from: data)
            return evolutionChain
        }catch {
            throw PokeError.invalidData
        }
    }
    
    static func fetchMoves(for moves: [Move]) async throws -> [MoveDetail] {
        return try await withThrowingTaskGroup(of: MoveDetail.self) { group in
            var tempMoves: [MoveDetail] = []
            for move in moves {
                group.addTask {
                    try await fetchMove(for: move.move.url)
                }
            }
            
            for try await move in group {
                tempMoves.append(move)
            }
            
            return tempMoves
        }
    }
    
    static func fetchMove(for moveUrl: String) async throws -> MoveDetail {
        let endpoint = moveUrl
        
        guard let url = URL(string: endpoint) else {
            throw PokeError.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw PokeError.invalidResponse
        }
        
        do {
            let move = try decoder.decode(MoveDetail.self, from: data)
            return move
        }catch {
            throw PokeError.invalidData
        }
    }
}
