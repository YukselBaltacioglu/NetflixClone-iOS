//
//  Extentions.swift
//  Netflix Clone
//
//  Created by Yüksel Baltacıoğlu on 11.11.2023.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
