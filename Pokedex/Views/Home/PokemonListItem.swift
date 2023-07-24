//
//  PokemonListItem.swift
//  Pokedex
//
//  Created by Seyit Murat Kaya on 13.07.2023.
//

import SwiftUI

struct PokemonListItem: View {
    
    var name: String?
    var pokedexId: Int?
    var types: [PType]?
        
    var body: some View {
        VStack(spacing: 0){
            HStack {
                Spacer()
                Text(String(format:"#%03d", pokedexId ?? 1))
                    .padding(.trailing)
                    .padding(.top,6)
                    .fontWeight(.bold)
                    .opacity(0.3)
            }
            
            VStack(alignment: .leading,spacing: 0){
                HStack {
                    Text(name?.capitalized ?? "")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                }
                HStack {
                    VStack{
                        ForEach(types ?? [], id: \.slot){ type in
                            Text(type.type.name.uppercased())
                                .font(.system(size: 10))
                                .padding(.horizontal, 8.0)
                                .padding(.vertical, 8.0)
                                .foregroundColor(.white)
                                .background(.ultraThinMaterial)
                                .cornerRadius(48)
                                .scaledToFit()
                                .minimumScaleFactor(0.5)
                                .lineLimit(1)
                                .bold()
                        }
                    }
                    Spacer()
                    PokemonImage(id:pokedexId ,pokeballOffsetHeight: 10,pokeballOffsetWeight: 5)
                    .frame(width: 100, height: 100)
                }
            }
            .padding(.leading,8)
        }
        .background(Color(types?[0].type.name ?? "grass"))
    }
}

struct PokemonListItem_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListItem(name: "Bulbasaur",pokedexId: 0)
            .previewLayout(.sizeThatFits)
    }
}
