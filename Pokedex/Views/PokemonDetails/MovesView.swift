//
//  MovesView.swift
//  Pokedex
//
//  Created by Seyit Murat Kaya on 15.07.2023.
//

import SwiftUI

struct MovesView: View {
    var body: some View {
        ScrollView {
            Text("Moves")
                .padding()
        }
        .background(.regularMaterial)
        .cornerRadius(16)
        .padding()
    }
}

struct MovesView_Previews: PreviewProvider {
    static var previews: some View {
        MovesView()
    }
}
