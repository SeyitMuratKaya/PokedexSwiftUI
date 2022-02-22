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
    var name:String
    var body: some View {
        
        ZStack{
            Color(networkManager.pokeTypeName1)
                .ignoresSafeArea()
            
            VStack{
                HStack{
                    VStack{
                        Text(networkManager.pokeName.uppercased())
                            .font(.title)
                            .fontWeight(.bold)
                        
                        HStack{
                            Text(networkManager.pokeTypeName1)
                                .fontWeight(.bold)
                            Text(networkManager.pokeTypeName2 ?? "")
                                .fontWeight(.bold)
                        }
                    }
                    
                    Spacer()
                    
                    Text("#\(String(format: "%03d", networkManager.pokeId))")
                        .fontWeight(.bold)
                }
                .padding()
                .foregroundColor(.white)
                
                PokemonImage(id: networkManager.pokeId)
                    .padding(.bottom, -70)
                    .zIndex(1)
                Spacer()
                
                RoundedRectangle(cornerRadius: 25)
                    .fill(.white)
                    .ignoresSafeArea()
                    .overlay(Text(networkManager.pokemonEntryText))
                
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            networkManager.fetchPokemon(url: url)
            networkManager.fetchEntry(url: "https://pokeapi.co/api/v2/pokemon-species/\(name)")
        }.tint(.black)
    }
}

struct PokemonView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonView(url:"https://pokeapi.co/api/v2/pokemon/1",name:"bulbasaur")
    }
}
