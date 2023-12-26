//
//  NetworkManager.swift
//  Movie Today
//
//  Created by Uladzislau Yatskevich on 26.12.23.
//

import Foundation

struct NetworkManager {
    static let environment: NetworkEnvironment = .production
    // MARK: - Указываем свой токен API
    static let movieAPIKey: String = "TRFZCT7-KY149CD-GGZ9SBT-Y0R9B3K"
    private let router = Router<MovieApi>()

    private func performRequest<T: Decodable>(for endpoint: MovieApi, completion: @escaping (Result<T, NetworkError>) -> Void) {
        router.request(endpoint) { data, response, error in
            guard error == nil else {
                return completion(.failure(.connectionError))
            }

            guard let data = data else {
                return completion(.failure(.noData))
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch let decodingError as DecodingError {
                let errorDescription = "Decoding error: \(decodingError.localizedDescription)"
                completion(.failure(.decodingError(errorDescription)))
            } catch {
                completion(.failure(.decodingError("Unknown decoding error")))
            }
        }
    }

    // MARK: - Поиск фильмов по названию
    func searchMovie(searchText: String, completion: @escaping (Result<MovieModel, NetworkError>) -> Void ) {
        performRequest(for: .searchMovie(searchText: searchText), completion: completion)
    }

    // MARK: - Получение фильмов из коллекции по названию коллекции, возможна сортировка по жанру
    func getMoviesFromCollection(collectionName: CollectionsMovies, genre: MovieGenres? = nil, completion: @escaping (Result<MovieModel,NetworkError>) -> Void ) {
        performRequest(for: .moviesFromCollection(collection: collectionName.rawValue, genre: genre?.rawValue), completion: completion)
    }

    // MARK: - Получение фильмов по жанру
    func getMoviesGenre(genre: MovieGenres, completion: @escaping (Result<MovieModel, NetworkError>) -> Void ) {
        performRequest(for: .genresMovie(genres: genre.rawValue), completion: completion)
    }

    // MARK: - Получение коллекций фильмов
    func getCollectionMovie(completion: @escaping (Result<CollectionMovieModel, NetworkError>) -> Void ) {
        performRequest(for: .collectionMovieList, completion: completion)
    }

}
