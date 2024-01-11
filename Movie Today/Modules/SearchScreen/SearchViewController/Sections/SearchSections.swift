//
//  SearchSections.swift
//  Movie Today
//
//  Created by macbook on 05.01.2024.
//

import Foundation

enum SearchSections: Int, CustomStringConvertible, CaseIterable {
    case actors, related
    var description: String {
        switch self {
        case .actors:
            return "Actors"
        case .related:
            return "Related"
            
        }
    }
}
