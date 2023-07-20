//
//  NavigationModel.swift
//  Pokedex
//
//  Created by Seyit Murat Kaya on 20.07.2023.
//

import SwiftUI

final class NavigationModel: ObservableObject {
    @Published var path = NavigationPath()
    
    static let shared: NavigationModel = NavigationModel()
    static let deneme: String = "deneme"
}
