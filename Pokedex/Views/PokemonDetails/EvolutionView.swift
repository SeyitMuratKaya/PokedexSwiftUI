//
//  EvolutionView.swift
//  Pokedex
//
//  Created by Seyit Murat Kaya on 15.07.2023.
//

import SwiftUI

struct EvolutionView: View {
    var body: some View {
        VStack() {
            Text("Evolution Chain")
            HStack {
                VStack{
                    PokemonImage()
                    Text("Bulbasaur")
                }
                VStack{
                    Image(systemName: "arrow.right")
                    Text("(Level 16)")
                }
                .padding()
                VStack{
                    PokemonImage(id: 2)
                    Text("Ivysaur")
                }
            }
            Divider()
            HStack {
                VStack{
                    PokemonImage(id: 2)
                    Text("Bulbasaur")
                }
                VStack{
                    Image(systemName: "arrow.right")
                    Text("(Level 16)")
                }
                .padding()
                VStack{
                    PokemonImage(id: 3)
                    Text("Ivysaur")
                }
            }
        }
    }
}

struct EvolutionView_Previews: PreviewProvider {
    static var previews: some View {
        EvolutionView()
    }
}
