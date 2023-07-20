//
//  BaseStatsView.swift
//  Pokedex
//
//  Created by Seyit Murat Kaya on 15.07.2023.
//
//
import SwiftUI

struct BaseStatsView: View {
    var stats: [Stat]?
    var pokemonType: String?
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
                                .tint(Color(pokemonType ??  "red"))
                        }
                    }
                }
                Text("Type Defenses")
                    .font(.title3)
                    .bold()
                Text("Type effectiveness of each type on \(pokemonName?.capitalized ?? "")")
                    .font(.subheadline)
                HStack{
                    //will be implemented later
                    Text("\(maxValue)")
                }
            }
            .padding()
        }
        .background(.regularMaterial)
        .cornerRadius(16)
        .padding()
    }
}

struct BaseStatsView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonView()
    }
}
