//
//  String+Pokedex.swift
//  Pokedex
//
//  Created by Seyit Murat Kaya on 20.07.2023.
//

import Foundation

extension String {
    func lastPathValue() -> Int {
        guard let last = URL(string: self)?.lastPathComponent else {
            return 1
        }
        return Int(last) ?? 1
    }
}
