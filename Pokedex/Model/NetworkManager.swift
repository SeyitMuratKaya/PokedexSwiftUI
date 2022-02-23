//
//  NetworkManager.swift
//  Pokedex
//
//  Created by Seyit Murat Kaya on 18.02.2022.
//

import Foundation
import Combine

class NetworkManager: ObservableObject{
    
    @Published var pokemon151 = [Result]()
    @Published var pokeId:Int = 0
    @Published var pokeName:String = ""
    @Published var pokeTypes = [SingleType]()
    @Published var pokeType = TypeName(name: "")
    @Published var pokeTypeName1: String = ""
    @Published var pokeTypeName2: String?
    @Published var pokemonHeight:Double = 0.0
    @Published var pokemonWeight:Double = 0.0
    @Published var pokemonEntries:[FlavorTextEntry] = []
    @Published var pokemonEntryText:String = ""
    @Published var pokemonAbility1:String = ""
    @Published var pokemonAbility2:String = ""
    
    
    func fetchEntry(url:String){
        if let url = URL(string: url){
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error == nil{
                    let decoder = JSONDecoder()
                    if let safeData = data{
                        do{
                            let result = try decoder.decode(PokemonEntry.self, from: safeData)
                            DispatchQueue.main.async {
                                self.pokemonEntryText = result.flavorTextEntries[0].flavorText
//                                print(self.pokemonEntryText)
                            }
                        }catch{
                            print(error)
                        }
                    }
                    
                }
            }
            task.resume()
        }
    }
    
    
    func fetchPokemon(url:String){
        if let url = URL(string: url){
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error == nil{
                    let decoder = JSONDecoder()
                    if let safeData = data{
                        do{
                            let result = try decoder.decode(Pokemon.self, from: safeData)
                            DispatchQueue.main.async {
                                self.pokeId = result.id
                                self.pokeName = result.name
                                self.pokemonHeight = result.height
                                self.pokemonWeight = result.weight
                                self.pokemonAbility1 = result.abilities[0].ability.name
                                self.pokemonAbility2 = result.abilities[1].ability.name
                                self.pokeTypes = result.types
                                self.pokeType = result.types[0].type
                                self.pokeTypeName1 = result.types[0].type.name!
                                if result.types.count > 1 {
                                    self.pokeTypeName2 = result.types[1].type.name!
//                                    print(self.pokeTypeName2)
                                }
                            }
                        }catch{
                            print(error)
                        }
                    }
                    
                }
            }
            task.resume()
        }
    }
    
    
    func fetch151(){
        if let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=151"){
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error == nil{
                    let decoder = JSONDecoder()
                    if let safeData = data{
                        do{
                            let result = try decoder.decode(Pokemon151.self, from: safeData)
                            DispatchQueue.main.async {
                                self.pokemon151 = result.results
//                                for i in 0...150{
//                                    print("\"" + self.pokemon151[i].name + "\"" + ":" + "\"" + "\(i+1)" + "\"" + ",")
//                                }
                            }
                        }catch{
                            print(error)
                        }
                    }
                    
                }
            }
            task.resume()
        }
    }

}
