    //
    //  YouTubeModel.swift
    //  Movie Today
    //
    //  Created by macbook on 30.12.2023.
    //

import Foundation

struct YouTubeModel: Codable {
    let items: [YouTubeVideoItem]
}

struct YouTubeVideoItem: Codable {
    let id: YouTubeVideoID
    let snippet: YouTubeVideoSnippet
}

struct YouTubeVideoID: Codable {
    let kind: String
    let videoId: String
}

struct YouTubeVideoSnippet: Codable {
    let publishedAt: String
    let channelId: String
    let title: String
    let description: String
}
