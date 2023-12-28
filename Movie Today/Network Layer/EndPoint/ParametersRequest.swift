//
//  ParametersRequest.swift
//  Movie Today
//
//  Created by Uladzislau Yatskevich on 26.12.23.
//

import Foundation

public enum MovieGenres: String, CaseIterable {
    case horror = "ужасы"
    case comedy = "комедия"
    case criminal = "криминал"
    case drama = "драма"
    case fantasy = "фантастика"
    case carton = "мультфильм"
    case documentary = "документальный"
}

public enum CollectionsMovies {
    case popular
    case collectionSlug(String)

    var rawValue: String {
        switch self {
            case .popular:
                return "popular-films"
            case .collectionSlug(let slug):
                return slug
        }
    }
}
