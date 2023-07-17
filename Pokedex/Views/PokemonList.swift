//
//  PokemonList.swift
//  Pokedex
//
//  Created by Seyit Murat Kaya on 21.02.2022.
//

import SwiftUI

struct PokemonList: View {
    @State private var pokemons: [Pokemon]?
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path){
            List {
                ForEach(pokemons ?? [], id: \.name) { pokemon in
                    Button { // (not using navigationlink) trick for removing navigation arrow
                        path.append(pokemon)
                    } label: {
                        PokemonListItem(name: pokemon.name,pokedexId: pokemon.id,types: pokemon.types)
                            .cornerRadius(8)
                    }
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .navigationTitle("Pokemons")
            .navigationDestination(for: Pokemon.self, destination: { pokemon in
                PokemonView(pokedexId: pokemon.id)
            })
        }
        .task {
            do {
                pokemons = try await fetchPokemons(from: 1, to: 4)
            } catch PokeError.invalidUrl {
                print("invalid url")
            }catch PokeError.invalidResponse {
                print("invalid response")
            }catch PokeError.invalidData {
                print("invalid data")
            }catch {
                print("unexpected error")
            }
        }
    }
}

extension PokemonList {
    func fetchPokemon(withId id: Int) async throws -> Pokemon {
        let endpoint = "https://pokeapi.co/api/v2/pokemon/\(id)"
        
        guard let url = URL(string: endpoint) else {
            throw PokeError.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw PokeError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let pokemon = try decoder.decode(Pokemon.self, from: data)
            return pokemon
        }catch {
            throw PokeError.invalidData
        }
    }
    
    func fetchPokemons(from: Int, to: Int) async throws -> [Pokemon] {
        var tempPokemons: [Pokemon] = []
        for id in from...to {
            let pokemon = try await fetchPokemon(withId: id)
            tempPokemons.append(pokemon)
        }
        return tempPokemons
    }
    
}

enum PokeError: Error {
    case invalidUrl
    case invalidResponse
    case invalidData
}

struct PokemonList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonList()
    }
}
