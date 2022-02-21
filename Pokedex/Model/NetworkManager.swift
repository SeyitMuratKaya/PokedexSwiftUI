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
    @Published var pokemon = Pokemon(id: 0, name: "")
    
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
                                self.pokemon = result
                                print(result)
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
