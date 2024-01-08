    //
    //  YoutubeManager.swift
    //  Movie Today
    //
    //  Created by macbook on 30.12.2023.
    //

import Foundation

struct YouTubeManager {
    func fetchData(query: String, completion: @escaping (Result<YouTubeModel, YouTubeError>) -> Void) {
        let request = YouTubeApiRequest(query: query)
        let urlString = request.buildURL()

        if let url = URL(string: urlString) {
            var urlRequest = URLRequest(url: url, timeoutInterval: Double.infinity)
            urlRequest.httpMethod = "GET"

            let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    completion(.failure(.networkError(error)))
                    return
                }
                guard let data = data else {
                    completion(.failure(.dataNotFound))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(YouTubeModel.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.jsonParsingError(error)))
                }
            }
            task.resume()
        }
    }
}
