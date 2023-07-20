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
    @EnvironmentObject private var navigationModel: NavigationModel
    
    var body: some View {
        NavigationStack(path: $navigationModel.path){
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
                            NavigationLink(value: element.fromPokemon) {
                                VStack{
                                    PokemonImage(id: element.fromPokemon?.id)
                                    Text(element.fromPokemon?.name.capitalized ?? "")
                                }
                            }
                            .buttonStyle(.plain)
                            VStack{
                                Image(systemName: "arrow.right")
                                Text("(Level \(element.minLevel))")
                                    .fixedSize(horizontal: true, vertical: false)
                            }
                            .padding()
                            NavigationLink(value: element.toPokemon) {
                                VStack{
                                    PokemonImage(id: element.toPokemon?.id)
                                    Text(element.toPokemon?.name.capitalized ?? "")
                                }
                            }
                            .buttonStyle(.plain)

                        }
                        Divider()
                    }
                }
                .padding()
            }
            .navigationDestination(for: Pokemon.self) { pokemon in
                PokemonView(pokemon: pokemon)
            }
        }
        .background(.regularMaterial)
        .cornerRadius(16)
        .padding()
        .task {
            await printChains()
        }
    }
}

extension EvolutionView {
    func printChains() async{
        do{
            chainElements.removeAll()
            
            var evolvesToArray = evolutionChain?.chain.evolvesTo
            let evolveCopy = evolvesToArray
            var firstPokemon = evolutionChain?.chain.species.name
            
            let count = evolvesToArray?.count ?? 0
            
            for i in 0..<count {
                while(!(evolvesToArray?.isEmpty ?? true)) {
                    let secondPokemon = evolvesToArray?[i].species.name
                    let minLevel = evolvesToArray?[i].evolutionDetails[0].minLevel
                    
                    
                    let fPokemon = try await PokemonAPI.fetchPokemon(withName: firstPokemon ?? "bulbasaur")
                    let sPokemon = try await PokemonAPI.fetchPokemon(withName: secondPokemon ?? "bulbasaur")
                    
                    chainElements.append(ChainElement(fromPokemon: fPokemon, minLevel: minLevel ?? 0, toPokemon: sPokemon))
                    
                    firstPokemon = secondPokemon
                    
                    evolvesToArray = evolvesToArray?[0].evolvesTo
                }
                firstPokemon = evolutionChain?.chain.species.name
                evolvesToArray = evolveCopy
            }
        }catch {
            print("error from evolutionView")
        }
    }
}

struct EvolutionView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonView()
            .environmentObject(NavigationModel.shared)
    }
}
