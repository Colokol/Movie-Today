

import Foundation

    // MARK: - MovieModel
struct MovieModel: Codable {
    let docs: [Doc]
    let total: Int
    let limit: Int
    let page: Int
    let pages: Int
}

    // MARK: - Doc
struct Doc: Hashable, Codable {
    let id: Int
    let externalId: ExternalId?
    let name: String
    let alternativeName: String?
    let enName: String?
    let names: [Name]?
    let type: String?
    let typeNumber: Int?
    let year: Int
    let description: String
    let shortDescription: String?
    let slogan: String?
    let status: String?
    let rating: Rating?
    let votes: Votes?
    let movieLength: Int?
    let ratingMpaa: String?
    let ageRating: Int?
    let logo: Logo?
    let poster: Poster?
    let backdrop: Poster?
    let videos: Videos?
    let genres: [Genres]?
    let countries: [Country]?
    let persons: [Person]?
    let reviewInfo: ReviewInfo?
    let seasonsInfo: [SeasonsInfo]?
    let budget: Budget?
    let fees: Fees?
    let premiere: Premiere?
    let similarMovies: [SequelsAndPrequel]?
    let sequelsAndPrequels: [SequelsAndPrequel]?
    let watchability: Watchability?
    let releaseYears: [ReleaseYear]?
    let top10: Int?
    let top250: Int?
    let ticketsOnSale: Bool?
    let totalSeriesLength: Int?
    let seriesLength: Int?
    let isSeries: Bool?
    let audience: [Audience]?
    let lists: [String]?
    let networks: [Network]?
    let updatedAt: String?
    let createdAt: String?
    let facts: [Fact]?
    let imagesInfo: ImagesInfo?
}

    //    // MARK: - Backdrop
struct Poster: Codable, Hashable {
    let url: String
    let previewUrl: String?
}

    // MARK: - Country
struct Genres: Codable, Hashable {
    let name: String
}

    // MARK: - Audience
struct Audience: Hashable, Codable {
    let count: Int?
    let country: String?
}

    // MARK: - Budget
struct Budget: Hashable, Codable {
    let value: Int?
    let currency: String?
}

    // MARK: - Country
struct Country: Hashable, Codable {
    let name: String?
}

    // MARK: - ExternalId
struct ExternalId: Hashable, Codable {
    let kpHD: String?
    let imdb: String?
    let tmdb: Int?
}

    // MARK: - Fact
struct Fact: Hashable, Codable {
    let value: String?
    let type: String?
    let spoiler: Bool?
}

    // MARK: - Fees
struct Fees: Hashable, Codable {
    let world: Budget?
    let russia: Budget?
    let usa: Budget?
}

    // MARK: - ImagesInfo
struct ImagesInfo: Hashable, Codable {
    let postersCount: Int?
    let backdropsCount: Int?
    let framesCount: Int?
}

    // MARK: - Logo
struct Logo: Hashable, Codable {
    let url: String?
}

    // MARK: - Name
struct Name: Hashable, Codable {
    let name: String?
    let language: String?
    let type: String?
}

    // MARK: - Network
struct Network: Hashable, Codable {
    let items: [NetworkItem]?
}

    // MARK: - NetworkItem
struct NetworkItem: Hashable, Codable {
    let name: String?
    let logo: Logo?
}

    // MARK: - Person
struct Person: Hashable, Codable {
    let id: Int?
    let photo: String?
    let name: String?
    let enName: String?
    let description: String?
    let profession: String?
    let enProfession: String?
}

    // MARK: - Premiere
struct Premiere: Hashable, Codable {
    let country: String?
    let world: String?
    let russia: String?
    let digital: String?
    let cinema: String?
    let bluray: String?
    let dvd: String?
}

    // MARK: - Rating
struct Rating: Hashable, Codable {
    let kp: Double
    let imdb: Double?
    let tmdb: Double?
    let filmCritics: Double?
    let russianFilmCritics: Double?
    let ratingAwait: Double?
}

    // MARK: - ReleaseYear
struct ReleaseYear: Hashable, Codable {
    let start: Int?
    let end: Int?
}

    // MARK: - ReviewInfo
struct ReviewInfo: Hashable, Codable {
    let count: Int?
    let positiveCount: Int?
    let percentage: String?
}

    // MARK: - SeasonsInfo
struct SeasonsInfo: Hashable, Codable {
    let number: Int?
    let episodesCount: Int?
}

    // MARK: - SequelsAndPrequel
struct SequelsAndPrequel: Hashable, Codable {
    let id: Int?
    let rating: Rating?
    let year: Int?
    let name: String?
    let enName: String?
    let alternativeName: String?
    let type: String?
    let poster: Poster?
}

    // MARK: - Videos
struct Videos: Hashable, Codable {
    let trailers: [Teaser]?
    let teasers: [Teaser]?
}

    // MARK: - Teaser
struct Teaser: Hashable, Codable {
    let url: String?
    let name: String?
    let site: String?
    let type: String?
    let size: Int?
}

    // MARK: - Votes
struct Votes: Hashable, Codable {
    let kp: Double?
    let imdb: Double?
    let tmdb: Double?
    let filmCritics: Double?
    let russianFilmCritics: Double?
    let votesAwait: Double?
}

    // MARK: - Watchability
struct Watchability: Hashable, Codable {
    let items: [WatchabilityItem]?
}

    // MARK: - WatchabilityItem
struct WatchabilityItem: Hashable, Codable {
    let name: String?
    let logo: Logo?
    let url: String?
}
