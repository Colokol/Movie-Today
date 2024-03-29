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
    private let jsonDecoder = JSONDecoder()


    private func performRequest<T: Decodable>(for endpoint: MovieApi, completion: @escaping (Result<T, Error>) -> Void) {
        router.request(endpoint) { [jsonDecoder] data, response, error in
            let result: Result<T, Error>

            if let error = error {
                result = .failure(error)
            }else if let response = response as? HTTPURLResponse {
                let resultResponse = handleNetworkResponse(response)

                switch resultResponse {
                    case .success(_):
                        guard let data = data else {
                            result = .failure(NetworkError.noData)
                            break
                        }

                        do {
                            let decodedData = try jsonDecoder.decode(T.self, from: data)
                            result = .success(decodedData)
                        } catch let decodingError as DecodingError {
                            result = .failure(decodingError)
                            print(decodingError)
                        } catch {
                            result = .failure(error)
                        }

                    case .failure(let error):
                        result = .failure(error)
                }

                DispatchQueue.main.async {
                    completion(result)
                }
            }
        }
    }

        // MARK: - Поиск фильма по ID
    func searchMovieFor(id:Int, completion: @escaping (Result<Doc, Error>) -> Void ) {
        performRequest(for: .searchMovieForID(id), completion: completion)
    }

    // MARK: - Поиск фильмов по названию
    func searchMovie(searchText: String, completion: @escaping (Result<MovieModel, Error>) -> Void ) {
        performRequest(for: .searchMovie(searchText: searchText), completion: completion)
    }

    // MARK: - Получение фильмов из коллекции по названию коллекции, возможна сортировка по жанру
    func getMoviesFromCollection(collectionName: CollectionsMovies, genre: MovieGenres? = nil, completion: @escaping (Result<MovieModel,Error>) -> Void ) {
        performRequest(for: .moviesFromCollection(collection: collectionName.rawValue, genre: genre?.rawValue), completion: completion)
    }

    // MARK: - Получение фильмов по жанру
    func getMoviesGenre(genre: MovieGenres, completion: @escaping (Result<MovieModel, Error>) -> Void ) {
        performRequest(for: .genresMovie(genres: genre.rawValue), completion: completion)
    }

    // MARK: - Получение коллекций фильмов
    func getCollectionMovie(completion: @escaping (Result<CollectionMovieModel, Error>) -> Void ) {
        performRequest(for: .collectionMovieList, completion: completion)
    }

    // MARK: - Поиск персон по имени
    func searchPerson(searchText: String, completion: @escaping (Result<FilmPersonnelModel, Error>) -> Void ) {
        performRequest(for: .searchPerson(searchText: searchText), completion: completion)
    }

    // MARK: - Получение фильмов по id актёра
    func getMovieFor(personId: Int, completion: @escaping (Result<MovieModel, Error>) -> Void ) {
        performRequest(for: .searchMovieFor(personID: personId), completion: completion)
    }

    // MARK: - Получение UpComing фильмов
    func getUpComingMovie(genre: MovieGenres, completion: @escaping (Result<MovieModel, Error>) -> Void ){
        performRequest(for: .upComingMovie(genre: genre.rawValue), completion: completion)
    }


}


extension NetworkManager {

    private func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String, NetworkError> {
        switch response.statusCode {
            case 200...299:
                return .success("Success: OK")
            case 401 :
                return .failure(.unauthorised)
            case 403:
                return .failure(.limit)
            case 400...499:
                return .failure(.clientError)
            case 500...599:
                return .failure(.serverError)
            default:
                return .failure(.errorEncode)
        }
    }
}
