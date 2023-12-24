//
//  Sections.swift
//  Movie Today
//
//  Created by macbook on 24.12.2023.
//

import Foundation

enum Sections: Int, CustomStringConvertible, CaseIterable {
    case compilation, categories, mostPopular
    var description: String {
        switch self {
        case .compilation:
            return "Compilation"
        case .categories:
            return "Categories"
        case .mostPopular:
            return "Most Popular"
        }
    }
}
