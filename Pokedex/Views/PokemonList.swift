//
//  PokemonList.swift
//  Pokedex
//
//  Created by Seyit Murat Kaya on 21.02.2022.
//

import SwiftUI

struct PokemonList: View {
    @ObservedObject var networkManager = NetworkManager()
    @State private var searchText = ""
    
    var body: some View {
        NavigationView{
            List{
                ForEach(Array(searchResults.enumerated()),id: \.1.name){ (index,pokemon) in
                    
                    NavigationLink{
                        PokemonView(url: pokemon.url,name: pokemon.name)
                    }label: {
                        AsyncImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(PokemonId[pokemon.name]!).png")) { image in
                            image
                        } placeholder: {
                            ProgressView()
                        }
                        Text(pokemon.name)
                        
                        
                    }
                    
                }
            }
            .searchable(text: $searchText)
            .autocapitalization(.none)
            .navigationTitle("Pokedex")
            .onAppear {
                networkManager.fetch151()
            }
            
        }
    }
    var searchResults: [Result] {
            if searchText.isEmpty {
                return networkManager.pokemon151
            } else {
                return networkManager.pokemon151.filter { $0.name.contains(searchText) }
            }
        }
}

struct PokemonList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonList()
    }
}
