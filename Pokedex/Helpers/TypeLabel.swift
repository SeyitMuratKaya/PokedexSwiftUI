//
//  TypeLabel.swift
//  Pokedex
//
//  Created by Seyit Murat Kaya on 19.07.2023.
//

import SwiftUI

struct TypeLabel: ViewModifier {
    var fontSize: CGFloat?
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: fontSize ?? 10))
            .padding(.horizontal, 16.0)
            .padding(.vertical, 4.0)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .background(.ultraThinMaterial)
            .cornerRadius(48)
    }
}
