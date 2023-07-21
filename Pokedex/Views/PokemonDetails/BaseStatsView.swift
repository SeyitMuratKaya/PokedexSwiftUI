//
//  BaseStatsView.swift
//  Pokedex
//
//  Created by Seyit Murat Kaya on 15.07.2023.
//
//
import SwiftUI

struct BaseType {
    var name: String
    var offense: [TypeWithEffect]
    var defense: [TypeWithEffect]
}

struct TypeWithEffect: Identifiable {
    let id = UUID().uuidString
    var name: String
    var effectValue: Double
}

struct BaseStatsView: View {
    @State var baseTypes: [BaseType] = []
    var stats: [Stat]?
    var pokemonTypes: [PType]?
    var pokemonName: String?
    
    var maxValue: Double {
        if let maxBaseStat = stats?.max(by: { $0.baseStat < $1.baseStat })?.baseStat {
            return Double(maxBaseStat)
        } else {
            return 0.0
        }
    }
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                Grid(alignment: .leading){
                    ForEach(stats ?? [],id: \.stat.name) { stat in
                        GridRow{
                            Text(stat.stat.name.capitalized)
                            Text("\(stat.baseStat)")
                            ProgressView(value: Double(stat.baseStat) ,total: maxValue)
                                .tint(Color(pokemonTypes?[0].type.name ?? "red"))
                        }
                    }
                }
                Text("Damage Relations")
                    .font(.title3)
                    .bold()
                Text("Type effectiveness of each type of \(pokemonName?.capitalized ?? "Bulbasaur")")
                    .font(.subheadline)
                    .opacity(0.3)
                    .bold()
                VStack(spacing: 0){
                    ForEach(baseTypes.indices, id: \.self) { index in
                        HStack(alignment: .top) {
                            Grid{
                                Text(baseTypes[index].name.capitalized)
                                    .font(.title3)
                            }
                            Grid {
                                Text("Offense")
                                    .font(.title3)
                                ForEach(baseTypes[index].offense) { item in
                                    Text(item.name.capitalized + " x\(item.effectValue)")
                                        .padding(.horizontal,8)
                                        .padding(.vertical,6)
                                        .background(Color(item.name))
                                        .cornerRadius(16)
                                }
                            }
                            Grid {
                                Text("Defense")
                                    .font(.title3)
                                ForEach(baseTypes[index].defense) { item in
                                    Text(item.name.capitalized + " x\(item.effectValue)")
                                        .padding(.horizontal,8)
                                        .padding(.vertical,6)
                                        .background(Color(item.name))
                                        .cornerRadius(16)
                                }
                            }
                        }
                    }
                }
                .padding(.bottom, 8)
            }
            .padding()
        }
        .task {
            do{
                let relations = try await PokemonAPI.fetchDamageRelations(for: pokemonTypes ?? [])
                
                for (index, relation) in relations.enumerated() {
                    baseTypes.append(BaseType(name: relation.name, offense: [], defense: []))
                    
                    for i in relation.damageRelations.doubleDamageTo ?? [] {
                        baseTypes[index].offense.append(TypeWithEffect(name: i.name, effectValue: 2.0))
                    }
                    for i in relation.damageRelations.halfDamageTo ?? [] {
                        baseTypes[index].offense.append(TypeWithEffect(name: i.name, effectValue: 0.5))
                    }
                    for i in relation.damageRelations.noDamageTo ?? [] {
                        baseTypes[index].offense.append(TypeWithEffect(name: i.name, effectValue: 0.0))
                    }
                    
                    for i in relation.damageRelations.doubleDamageFrom ?? [] {
                        baseTypes[index].defense.append(TypeWithEffect(name: i.name, effectValue: 2.0))
                    }
                    for i in relation.damageRelations.halfDamageFrom ?? [] {
                        baseTypes[index].defense.append(TypeWithEffect(name: i.name, effectValue: 0.5))
                    }
                    for i in relation.damageRelations.noDamageFrom ?? [] {
                        baseTypes[index].defense.append(TypeWithEffect(name: i.name, effectValue: 0.0))
                    }
                }
                print(baseTypes)
            }catch PokeError.invalidUrl {
                print("invalid url")
            }catch PokeError.invalidResponse {
                print("invalid response")
            }catch PokeError.invalidData {
                print("invalid data")
            }catch {
                print("unexpected error from BaseStatsView")
            }
        }
        .background(.regularMaterial)
        .cornerRadius(16)
        .padding()
    }
}

struct BaseStatsView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonView()
            .environmentObject(NavigationModel.shared)
    }
}
