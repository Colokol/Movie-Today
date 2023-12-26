

import Foundation

    // MARK: - FilmModel
struct MovieModel: Codable {
    let docs: [Doc]
    let total: Int
    let limit: Int
    let page: Int
    let pages: Int
}

    // MARK: - Doc
struct Doc: Codable {
    let id: Int
    let name: String
    let alternativeName: String?
    let year: Int
    let description: String
    let shortDescription: String?
    let movieLength: Int?
    let poster: Poster
    let rating: Rating?
    let votes: Votes?
    let genres: [Genres]?
    let ratingMpaa: String?
    let ageRating: Int?
}

    // MARK: - Backdrop
struct Poster: Codable {
    let url: String?
    let previewUrl: String?
}

    // MARK: - Country
struct Genres: Codable {
    let name: String
}
    // MARK: - Rating
struct Rating: Codable {
    let kp: Double?
}

    // MARK: - Votes
struct Votes: Codable {
    let kp: Double?
}
