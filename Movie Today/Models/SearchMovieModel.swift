//
//  SearchMovieModel.swift
//  Movie Today
//
//  Created by Uladzislau Yatskevich on 28.12.23.
//

import Foundation

    // MARK: - FilmModel
struct SearchMovieModel: Decodable, Hashable {
    let docs: [DocSearch]
    let total: Int
    let limit: Int
    let page: Int
    let pages: Int
}

    // MARK: - Doc
struct DocSearch: Decodable, Hashable {
    let id: Int?
    let name: String?
    let alternativeName: String?
    let year: Int?
    let description: String?
    let shortDescription: String?
    let movieLength: Int?
    let poster: PosterSearch?
    let rating: RatingSearch?
    let votes: VotesSearch?
    let genres: [Genres?]?
    let ratingMpaa: String?
    let ageRating: Int?
    let type: String?
}

    // MARK: - Backdrop
struct PosterSearch: Decodable, Hashable {
    let url: String?
    let previewUrl: String?
}

    // MARK: - Country
struct GenresSearch: Decodable, Hashable {
    let name: String?
}
    // MARK: - Rating
struct RatingSearch: Decodable, Hashable {
    let kp: Double?
}

    // MARK: - Votes
struct VotesSearch: Decodable, Hashable {
    let kp: Double?
}
