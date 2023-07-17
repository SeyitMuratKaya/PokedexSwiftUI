//
//  PokemonImage.swift
//  Pokedex
//
//  Created by Seyit Murat Kaya on 17.07.2023.
//

import SwiftUI

struct PokemonImage: View {
    var id: Int? = 1
    var scaleWidth: Double?
    var scaleHeight: Double?
    var pokeballOffsetHeight: Double?
    var pokeballOffsetWeight: Double?
    var pokeballColor: Color? = .white
    
    var body: some View {
        ZStack{
            Image("pokeball")
                .renderingMode(.template)
                .resizable()
                .foregroundColor(pokeballColor)
                .opacity(0.3)
                .aspectRatio(contentMode: .fit)
                .scaleEffect(CGSize(width: scaleWidth ?? 1, height: scaleHeight ?? 1))
                .offset(CGSize(width: pokeballOffsetWeight ?? 0, height: pokeballOffsetHeight ?? 0))
            AsyncImage(url: URL(string: String(format: "https://assets.pokemon.com/assets/cms2/img/pokedex/full/%03d.png", id ?? 1))) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
            } placeholder: {
                ProgressView()
                    .aspectRatio(contentMode: .fit)
            }
        }
    }
}

struct PokemonImage_Previews: PreviewProvider {
    static var previews: some View {
        PokemonImage()
    }
}
