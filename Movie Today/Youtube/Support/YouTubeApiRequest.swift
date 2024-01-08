    //
    //  YoutubeApiRequest.swift
    //  Movie Today
    //
    //  Created by macbook on 30.12.2023.
    //

import Foundation
struct YouTubeApiRequest {
    let baseUrl = "https://www.googleapis.com/youtube/v3/search"
    var part: String = "snippet"
    var query: String
    var type: String = "video"
    var apiKey: String = "AIzaSyBwPJsg9JJkfdxqEn_H70ebbsZyXM9a24k"

    func buildURL() -> String {
        let queryItems = [
            URLQueryItem(name: "part", value: part),
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "type", value: type),
            URLQueryItem(name: "key", value: apiKey)
        ]

        var urlComponents = URLComponents(string: baseUrl)
        urlComponents?.queryItems = queryItems

        return urlComponents?.url?.absoluteString ?? ""
    }
}
