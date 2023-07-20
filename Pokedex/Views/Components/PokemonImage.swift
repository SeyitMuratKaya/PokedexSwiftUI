//
//  PokemonImage.swift
//  Pokedex
//
//  Created by Seyit Murat Kaya on 17.07.2023.
//

import SwiftUI

struct PokemonImage: View {
    var id: Int? = 1
    var scaleWidth: Double = 1.0
    var scaleHeight: Double = 1.0
    var pokeballOffsetHeight: Double = 0.0
    var pokeballOffsetWeight: Double = 0.0
    var pokeballColor: Color = .white
    
    let imageUrl: String = "https://assets.pokemon.com/assets/cms2/img/pokedex/full/%03d.png"
    
    var body: some View {
        ZStack{
            Image("pokeball")
                .renderingMode(.template)
                .resizable()
                .foregroundColor(pokeballColor)
                .opacity(0.3)
                .aspectRatio(contentMode: .fit)
                .scaleEffect(CGSize(width: scaleWidth, height: scaleHeight))
                .offset(CGSize(width: pokeballOffsetWeight, height: pokeballOffsetHeight))
            AsyncImage(url: URL(string: String(format: imageUrl, id ?? 1))) { image in
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
