//
//  FilmPersonnelModel.swift
//  Movie Today
//
//  Created by Uladzislau Yatskevich on 3.01.24.
//

import Foundation

struct FilmPersonnelModel: Codable {
    let docs: [Person]
    let total: Int
    let limit: Int
    let page: Int
    let pages: Int

}

struct PersonModel: Codable {
    let id: Int
    let age: Int?
    let countAwards: Int?
    let createdAt: String?
    let enName: String?
    let growth: Int?
    let movies: [Movie]?
    let name: String?
    let photo: String?
    let sex: String?
    let updatedAt: String?
}

    // MARK: - Movie
struct Movie: Codable {
    let id: Int
    let name: String?
    let general: Bool?
    let description: String?
}

    
