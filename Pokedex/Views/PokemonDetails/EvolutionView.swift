//
//  EvolutionView.swift
//  Pokedex
//
//  Created by Seyit Murat Kaya on 15.07.2023.
//

import SwiftUI

struct EvolutionView: View {
    var evolutionChain: EvolutionModel?
    @State private var chainElements: [ChainElement] = []
    
    func printChains(){
        chainElements.removeAll()

        var evolvesToArray = evolutionChain?.chain.evolvesTo
        let evolveCopy = evolvesToArray
        var firstPokemon = evolutionChain?.chain.species.name
        var firstPokemonUrl = evolutionChain?.chain.species.url

        let count = evolvesToArray?.count ?? 0

        for i in 0..<count {
            while(!(evolvesToArray?.isEmpty ?? true)) {
                let secondPokemon = evolvesToArray?[i].species.name
                let secondPokemonUrl = evolvesToArray?[i].species.url
                let minLevel = evolvesToArray?[i].evolutionDetails[0].minLevel

                chainElements.append(ChainElement(from: firstPokemon, fromUrl: firstPokemonUrl, minLevel: minLevel ?? 0, to: secondPokemon, toUrl: secondPokemonUrl))

                firstPokemon = secondPokemon
                firstPokemonUrl = secondPokemonUrl

                evolvesToArray = evolvesToArray?[0].evolvesTo
            }
            firstPokemon = evolutionChain?.chain.species.name
            firstPokemonUrl = evolutionChain?.chain.species.url
            evolvesToArray = evolveCopy
        }
    }
    
    var body: some View {
        ScrollView{
            VStack {
                HStack{
                    Text("Evolution Chain")
                        .font(.title3)
                        .bold()
                    Spacer()
                }
                ForEach(chainElements, id: \.self) { element in
                    HStack {
                        VStack{
                            PokemonImage(id: Int(URL(string: element.fromUrl ?? "")?.lastPathComponent ?? ""))
                            Text(element.from?.capitalized ?? "")
                        }
                        VStack{
                            Image(systemName: "arrow.right")
                            Text("(Level \(element.minLevel))")
                                .fixedSize(horizontal: true, vertical: false)
                        }
                        .padding()
                        VStack{
                            PokemonImage(id: Int(URL(string: element.toUrl ?? "")?.lastPathComponent ?? ""))
                            Text(element.to?.capitalized ?? "")
                        }
                    }
                    Divider()
                }
            }
            .padding()
        }
        .background(.regularMaterial)
        .cornerRadius(16)
        .padding()
        .onAppear {
            printChains()
        }
    }
}

struct EvolutionView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonView()
    }
}
