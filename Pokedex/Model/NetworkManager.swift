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
    @Published var pokeTypeName: String = ""
        
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
                                self.pokeTypes = result.types
                                self.pokeType = result.types[0].type
                                self.pokeTypeName = result.types[0].type.name
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
