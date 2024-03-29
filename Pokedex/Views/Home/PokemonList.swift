//
//  PokemonList.swift
//  Pokedex
//
//  Created by Seyit Murat Kaya on 21.02.2022.
//

import SwiftUI

struct PokemonList: View {
    @State private var pokemons: [Pokemon]?
    @EnvironmentObject private var navigationModel: NavigationModel
    @State private var searchText: String = ""
    
    private var twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
    
    var searchList: [Pokemon] {
        let text = searchText.lowercased()
        
        if text.isEmpty {
            return pokemons ?? []
        }else {
            return pokemons?.filter{ $0.name.contains(text) } ?? []
        }
    }
    
    var body: some View {
        NavigationStack(path: $navigationModel.path){
            ScrollView {
                LazyVGrid(columns: twoColumnGrid){
                    ForEach(searchList, id: \.name) { pokemon in
                        Button { // (not using navigationlink) trick for removing navigation arrow
                            navigationModel.path.append(pokemon)
                        } label: {
                            PokemonListItem(name: pokemon.name,pokedexId: pokemon.id,types: pokemon.types)
                                .cornerRadius(16)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
            .navigationTitle("Pokemons")
            .navigationDestination(for: Pokemon.self, destination: { pokemon in
                PokemonView(pokemon: pokemon)
            })
        }
        .searchable(text: $searchText)
        .task {
            do {
                pokemons = try await PokemonAPI.fetchPokemons(from: 1, to: 151)
                pokemons?.sort {
                    $0.id < $1.id
                }
            } catch PokeError.invalidUrl {
                print("invalid url")
            }catch PokeError.invalidResponse {
                print("invalid response")
            }catch PokeError.invalidData {
                print("invalid data")
            }catch {
                print("unexpected error from PokemonList")
            }
        }
    }
}

struct PokemonList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonList()
            .environmentObject(NavigationModel.shared)
    }
}
