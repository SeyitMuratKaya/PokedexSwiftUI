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
    
    var body: some View {
        VStack{
            HStack{
                Text("Height:")
                    .foregroundColor(Color.gray)
                Spacer()
                Text("\(String(round(10 * height)/100)) m")
                Spacer()
            }.padding()
            HStack{
                Text("Weight:")
                    .foregroundColor(Color.gray)
                Spacer()
                Text("\(String(round(10 * weight)/100)) kg")
                Spacer()
            }.padding()
            HStack{
                Text("Abilities:")
                    .foregroundColor(Color.gray)
                Spacer()
                Text("Ability 1")
                Text("Ability 2")
                Spacer()
            }.padding()
//        Spacer()
        }
        .frame(height: UIScreen.main.bounds.size.width)
        .background(.white)
    }
}

struct PokemonDetail_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetail(height: 0, weight: 0)
    }
}
