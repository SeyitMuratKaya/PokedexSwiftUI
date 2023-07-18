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
    
    func printChain(){
        chainElements.removeAll()
        
        var chain = evolutionChain?.chain.evolvesTo
        var firstPokemon = evolutionChain?.chain.species.name
        var firstPokemonUrl = evolutionChain?.chain.species.url
        
        while(!(chain?.isEmpty ?? true)){
            let secondPokemon = chain?[0].species.name
            let secondPokemonUrl = chain?[0].species.url
            let minLevel = chain?[0].evolutionDetails[0].minLevel
            
            chainElements.append(ChainElement(from: firstPokemon, fromUrl: firstPokemonUrl, minLevel: minLevel ?? 0, to: secondPokemon,toUrl: secondPokemonUrl))
            firstPokemon = secondPokemon
            firstPokemonUrl = secondPokemonUrl
            
            chain = chain?[0].evolvesTo
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
            printChain()
        }
    }
}

struct ChainElement: Hashable {
    var from: String?
    var fromUrl: String?
    var minLevel: Int
    var to: String?
    var toUrl: String?
}

struct EvolutionView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonView()
    }
}
