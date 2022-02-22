//
//  PokemonList.swift
//  Pokedex
//
//  Created by Seyit Murat Kaya on 21.02.2022.
//

import SwiftUI

struct PokemonList: View {
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        NavigationView{
            List(networkManager.pokemon151){ pokemon in
                NavigationLink{
                    PokemonView(url: pokemon.url,name: pokemon.name)
                }label: {
                    Text(pokemon.name)
                }
            }
            .navigationTitle("Pokedex")
            .onAppear {
                networkManager.fetch151()
            }
            
        }
    }
}

struct PokemonList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonList()
    }
}
