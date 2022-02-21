//
//  PokemonView.swift
//  Pokedex
//
//  Created by Seyit Murat Kaya on 21.02.2022.
//

import SwiftUI

struct PokemonView: View {
    @ObservedObject var networkManager = NetworkManager()
    var url:String
    
    var body: some View {
        VStack{
            Text(networkManager.pokeName.uppercased())
                .font(.title)
            PokemonImage(id: networkManager.pokeId)
            Text(networkManager.pokeTypeName)
            Spacer()
        }.onAppear {
            networkManager.fetchPokemon(url: url)
        }
    }
}

struct PokemonView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonView(url:"")
    }
}
