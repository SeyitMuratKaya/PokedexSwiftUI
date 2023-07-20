//
//  AboutInfo.swift
//  Pokedex
//
//  Created by Seyit Murat Kaya on 15.07.2023.
//

import SwiftUI

struct AboutView: View {
    
    var pokedexEntry: String?
    var height: Int?
    var weight: Int?
    var genderRate: Int?
    
    var genderRatePercent: Double {
        if let genderRate {
            if genderRate > 0 {
                return (Double(genderRate) * 100.0)/8.0
            }
        }
        return 0
    }
    
    var heightConverted: String {
        let heightDecimeters = Measurement(value: Double(height ?? 0), unit: UnitLength.decimeters)
        
        let heightConverted = heightDecimeters.converted(to: UnitLength.meters)
        
        return String(format: "%.1f", heightConverted.value) + " m"
    }
    
    var weightConverted: String {
        let weightConverted = Double(weight ?? 0) / 10
        
        return String(format: "%.1f", weightConverted) + " kg"
    }
    
    var pokedexCleanEntry: String {
        return pokedexEntry?.replacingOccurrences(of: "\n", with: " ") ?? ""
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading ,spacing: 0) {
                Text(pokedexCleanEntry)
                    .fontWeight(.medium)
                    .padding()
                
                HStack(){
                    VStack(alignment: .leading){
                        Text("Height")
                            .fontWeight(.semibold)
                        Text(heightConverted)
                    }
                    .padding()
                    Spacer()
                    VStack(alignment: .leading){
                        Text("Weight")
                            .fontWeight(.semibold)
                        Text(weightConverted)
                    }
                    .padding()
                    Spacer()
                }
                .background(.regularMaterial)
                .cornerRadius(15)
                .shadow(radius: 10)
                .padding()
                
                VStack(alignment: .leading, spacing: 0){
                    Text("Breeding")
                        .font(.title3)
                        .bold()
                    HStack{
                        Text("Gender:")
                        Spacer()
                        HStack{
                            Image("male")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                            Text(String(format: "%.1f", 100 - genderRatePercent))
                        }
                        Spacer()
                        HStack{
                            Image("female")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                            Text(String(format: "%.1f", genderRatePercent))
                        }
                        Spacer()
                    }
                    .padding(.top)
                }
                .padding()
            }
        }
        .background(.regularMaterial)
        .cornerRadius(16)
        .padding()
    }
}


struct AboutInfo_Previews: PreviewProvider {
    static var previews: some View {
        PokemonView()
    }
}
