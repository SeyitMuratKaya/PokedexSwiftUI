//
//  PokemonView.swift
//  Pokedex
//
//  Created by Seyit Murat Kaya on 21.02.2022.
//

import SwiftUI

struct PokemonView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var pokemon: Pokemon?
    @State private var pokemonSpecies: PokemonSpecies?
    @State private var evolutionChain: EvolutionModel?
    
    @State private var tabSelection: InfoCategories = .about
    
    var pokedexId: Int = 1
    
    var body: some View {
        VStack(spacing: 0){
            HStack{
                Button{
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.white)
                        .bold()
                }
                Spacer()
                Button {
                    print("")
                } label: {
                    Image(systemName: "heart")
                        .foregroundColor(.white)
                        .bold()
                }
            }
            .padding(.horizontal)
            VStack(spacing: 0){
                HStack{
                    Text(pokemon?.name.capitalized ?? "")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                    Spacer()
                    Text(String(format:"#%03d", pokemon?.id ?? 1))
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .fontWeight(.heavy)
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                
                HStack{
                    ForEach(pokemon?.types ?? [], id: \.slot){ type in
                        Text(type.type.name.uppercased())
                            .font(.system(size: 12))
                            .padding(.horizontal, 8.0)
                            .padding(.vertical, 8.0)
                            .foregroundColor(.white)
                            .background(.ultraThinMaterial)
                            .cornerRadius(48)
                            .bold()
                    }
                    
                    Spacer()
                    
                    Text("Seed Pokemon")// from species
                        .foregroundColor(.white)
                        .bold()
                }
                .padding(.horizontal)
                
                PokemonImage(id: pokedexId,scaleWidth: 2.5, scaleHeight: 2.5)
                .padding(.top)
            }
            Picker("Info", selection: $tabSelection) {
                ForEach(InfoCategories.allCases) { category in
                    Text(category.rawValue.capitalized)
                }
            }
            .padding(.horizontal)
            .pickerStyle(.segmented)
            
            TabView(selection: $tabSelection) {
                AboutView(pokedexEntry: pokemonSpecies?.flavorTextEntries[0].flavorText, height: pokemon?.height, weight: pokemon?.weight, genderRate: pokemonSpecies?.genderRate).tag(InfoCategories.about)
                BaseStatsView(stats: pokemon?.stats,pokemonType: pokemon?.types[0].type.name,pokemonName: pokemon?.name).tag(InfoCategories.stats)
                EvolutionView(evolutionChain: evolutionChain).tag(InfoCategories.evolution)
                MovesView(moves: pokemon?.moves).tag(InfoCategories.moves)
            }
            .animation(.easeInOut, value: tabSelection)
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        .navigationBarBackButtonHidden(true)
        .background(Color(pokemon?.types[0].type.name ?? "grass"))
        .task {
            do {
                pokemon = try await fetchPokemon(withId: pokedexId)
                pokemonSpecies = try await fetchPokemonSpecies(withId: pokedexId)
                evolutionChain = try await fetchEvolutionChain(fromUrl: pokemonSpecies?.evolutionChain.url ?? "")
            } catch PokeError.invalidUrl {
                print("invalid url")
            }catch PokeError.invalidResponse {
                print("invalid response")
            }catch PokeError.invalidData {
                print("invalid data")
            }catch {
                print("unexpected error from PokemonView")
            }
        }
    }
}

extension PokemonView {
    func fetchPokemon(withId id: Int) async throws -> Pokemon {
        let endpoint = "https://pokeapi.co/api/v2/pokemon/\(id)"
        
        guard let url = URL(string: endpoint) else {
            throw PokeError.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw PokeError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let pokemon = try decoder.decode(Pokemon.self, from: data)
            return pokemon
        }catch {
            throw PokeError.invalidData
        }
    }
    
    func fetchPokemonSpecies(withId id: Int) async throws -> PokemonSpecies{
        let endpoint = "https://pokeapi.co/api/v2/pokemon-species/\(id)"
        
        guard let url = URL(string: endpoint) else {
            throw PokeError.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw PokeError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let pokemonSpecies = try decoder.decode(PokemonSpecies.self, from: data)
            return pokemonSpecies
        }catch {
            throw PokeError.invalidData
        }
    }
    
    func fetchEvolutionChain(fromUrl url: String) async throws -> EvolutionModel {
        let endpoint = url
        
        guard let url = URL(string: endpoint) else {
            throw PokeError.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw PokeError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let evolutionChain = try decoder.decode(EvolutionModel.self, from: data)
            return evolutionChain
        }catch {
            throw PokeError.invalidData
        }
    }
}

struct PokemonView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonView()
    }
}
