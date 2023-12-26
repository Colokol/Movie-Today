//
//  CollectionFilmModel.swift
//  Movie Today
//
//  Created by Uladzislau Yatskevich on 26.12.23.
//

import Foundation

    // MARK: - CollectionFilmModel
struct CollectionMovieModel: Decodable, Hashable {
    let docs: [Collection]
    let limit: Int
    let page: Int
    let pages: Int
}

    // MARK: - Collection
struct Collection: Decodable, Hashable {
    let category: String?
    let name: String
    let slug: String
    let moviesCount: Int?
    let cover: Poster?
    let createdAt: String?
    let updatedAt: String?
}
