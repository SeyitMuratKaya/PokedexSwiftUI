//
//  PokemonImage.swift
//  Pokedex
//
//  Created by Seyit Murat Kaya on 21.02.2022.
//

import SwiftUI

struct PokemonImage: View {
    var id:Int
    
    var body: some View {
        AsyncImage(url: URL(string: "https://assets.pokemon.com/assets/cms2/img/pokedex/full/\(String(format: "%03d", id)).png")) { image in
            image.resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 300)
                
        } placeholder: {
            ProgressView()
        }
    }
}

struct PokemonImage_Previews: PreviewProvider {
    static var previews: some View {
        PokemonImage(id:001)
    }
}
