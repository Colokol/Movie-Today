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
    case genresMovie(genres:String)
    case collectionMovie(name:String)
    case collectionMovieList
    case searchMovie(searchText:String)
}

extension MovieApi: EndpointType {

    private static let defaultPage = 1
    private static let defaultLimit = 10


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
            case .collectionMovie:
                return "movie"
            case .collectionMovieList:
                return "list"
            case .searchMovie:
                return "movie/search"
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
                                        "page": MovieApi.defaultPage],
                        additionalHeaders: headers
                    )
            case .collectionMovie(name: let name):
                return .requestParametersAndHeaders(bodyParameters: nil,
                                                    urlParameters: ["lists":name,
                                                                    "limit": MovieApi.defaultLimit,
                                                                    "page": MovieApi.defaultPage],
                                                    additionalHeaders: headers)
            case .collectionMovieList:
                return .requestParametersAndHeaders(bodyParameters: nil,
                                                    urlParameters: ["limit": MovieApi.defaultLimit,
                                                                    "page": MovieApi.defaultPage],
                                                    additionalHeaders: headers)
            case .searchMovie(searchText: let searchMovie):
                return .requestParametersAndHeaders(bodyParameters: nil,
                                                    urlParameters:["query":"\(searchMovie)",
                                                                   "limit": MovieApi.defaultLimit,
                                                                   "page": MovieApi.defaultPage],
                                                    additionalHeaders: headers)
        }
    }


    var headers: HTTPHeaders? {
        return ["X-API-KEY":NetworkManager.movieAPIKey]
    }
}
