    //
    //  YouTubeError.swift
    //  Movie Today
    //
    //  Created by macbook on 30.12.2023.
    //

import Foundation
enum YouTubeError: Error {
    case networkError(Error)
    case dataNotFound
    case jsonParsingError(Error)
}
