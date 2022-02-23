//
//  PokemonDetail.swift
//  Pokedex
//
//  Created by Seyit Murat Kaya on 23.02.2022.
//

import SwiftUI

struct PokemonDetail: View {
    
    var height:Double
    var weight:Double
    var ability1:String
    var ability2:String
    
    var body: some View {
        VStack{
            HStack{
                Text("Height:")
                    .foregroundColor(Color.gray)
                Spacer()
                Text("\(String(round(10 * height)/100)) m")
//                Spacer()
            }.padding()
            HStack{
                Text("Weight:")
                    .foregroundColor(Color.gray)
                Spacer()
                Text("\(String(round(10 * weight)/100)) kg")
//                Spacer()
            }.padding()
            HStack{
                Text("Abilities:")
                    .foregroundColor(Color.gray)
                Spacer()
                Text(ability1)
                Text(ability2)
//                Spacer()
            }.padding()
        }
        .frame(height: UIScreen.main.bounds.size.width)
        .background(.white)
    }
}

struct PokemonDetail_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetail(height: 0, weight: 0,ability1: "deneme",ability2: "deneme")
    }
}
