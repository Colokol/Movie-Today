    //
    //  MovieEndPoint.swift
    //  Movie Today
    //
    //  Created by Uladzislau Yatskevich on 26.12.23.
    //

import Foundation

enum NetworkEnvironment {
    case production
}

public enum MovieApi {
    case genresMovie(genres: String)
    case moviesFromCollection(collection: String, genre: String?)
    case collectionMovieList
    case upComingMovie
    case searchMovie(searchText: String)
    case searchPerson(searchText: String)
    case searchMovieForID(_ id:Int)
    case searchMovieFor(personID: Int)
}

extension MovieApi: EndpointType {

    var environmentBaseURL : String {
        switch NetworkManager.environment {
            case .production: return "https://api.kinopoisk.dev/v1.4/"
        }
    }

    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }

    var path: String {
        switch self {
            case .genresMovie:
                return "movie"
            case .moviesFromCollection:
                return "movie"
            case .collectionMovieList:
                return "list"
            case .searchMovie:
                return "movie/search"
            case .searchPerson:
                return "person/search"
            case .searchMovieFor:
                return "movie"
            case .searchMovieForID(let id):
                return "movie/\(id)"
            case .upComingMovie:
                return "movie"
        }
    }

    var httpMethod: HTTPMethod {
        return .get
    }

    var task: HTTPTask {
        switch self {
            case .genresMovie(genres: let genre):
                return .requestParametersAndHeaders(
                    bodyParameters: nil,
                    urlParameters: ["genres.name": genre,
                                    "limit": MovieApi.defaultLimit,
                                    "page": MovieApi.defaultPage,
                                    "notNullFields":MovieApi.notNilParameters,
                                    "selectFields":MovieApi.selectFields ],
                    additionalHeaders: headers
                )
            case .moviesFromCollection(collection: let name, genre: let genre):
                var urlParameters: [String: Any] = ["lists": name,
                                                    "limit": MovieApi.defaultLimit,
                                                    "page": MovieApi.defaultPage,
                                                    "selectFields":MovieApi.selectFields]
                if let genre = genre {
                    urlParameters["genres.name"] = genre
                }
                return .requestParametersAndHeaders(
                    bodyParameters: nil,
                    urlParameters: urlParameters,
                    additionalHeaders: headers
                )

            case .collectionMovieList:
                return .requestParametersAndHeaders(bodyParameters: nil,
                                                    urlParameters: ["limit": MovieApi.defaultLimit,
                                                                    "page": MovieApi.defaultPage,
                                                                    "sortField":"name",
                                                                    "sortType":"-1",
                                                                    "notNullFields":["slug","cover.url"]],
                                                    additionalHeaders: headers)
            case .searchMovie(searchText: let searchMovie):
                return .requestParametersAndHeaders(bodyParameters: nil,
                                                    urlParameters:["query":"\(searchMovie)",
                                                                   "limit": MovieApi.defaultLimit,
                                                                   "page": MovieApi.defaultPage,
                                                                   "notNullFields": MovieApi.notNilParameters],
                                                    additionalHeaders: headers)
            case .searchPerson(searchText: let searchPerson):
                return .requestParametersAndHeaders(bodyParameters: nil,
                                                    urlParameters:["query":"\(searchPerson)",
                                                                   "limit": 250,
                                                                   "page": MovieApi.defaultPage],
                                                    additionalHeaders: headers)
            case .searchMovieFor(personID: let id):
                return .requestParametersAndHeaders(
                    bodyParameters: nil,
                    urlParameters: ["persons.id":"\(id)",
                                    "limit": MovieApi.defaultLimit,
                                    "page": MovieApi.defaultPage],
                    additionalHeaders: headers
                )
            case .searchMovieForID:
                return .requestParametersAndHeaders(
                    bodyParameters: nil,
                    urlParameters: nil,
                    additionalHeaders: headers
                )
            case .upComingMovie:
                return .requestParametersAndHeaders(bodyParameters: nil,
                                                    urlParameters:["limit":MovieApi.defaultLimit,
                                                                   "page":MovieApi.defaultPage,
                                                                   "notNullFields":MovieApi.upComingNotNilParameters,
                                                                   "type":"movie",
                                                                   "status":"filming",
                                                                   "year":"2024",
                                                                   "votes.await":"2000-99999"],
                                                    additionalHeaders: headers)
        }
    }


    var headers: HTTPHeaders? {
        return ["X-API-KEY":NetworkManager.movieAPIKey]
    }
}


// MARK: - Static urlParameters
extension MovieApi {
    private static let defaultPage = 1
    private static let defaultLimit = 10
    private static let selectFields = ["persons","id","name","description","genres","videos","movieLength","poster","year", "type", "rating","ageRating"]
    private static let notNilParameters = ["ageRating", "genres.name", "poster.url", "movieLength", "rating.kp", "type", "persons.name"]
    private static let upComingNotNilParameters = ["genres.name", "poster.url",  "type", "persons.name"]
}
