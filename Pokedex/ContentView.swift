//
//  ContentView.swift
//  Pokedex
//
//  Created by Seyit Murat Kaya on 18.02.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var navigationModel = NavigationModel()
    
    var body: some View {
        PokemonList()
            .environmentObject(navigationModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
