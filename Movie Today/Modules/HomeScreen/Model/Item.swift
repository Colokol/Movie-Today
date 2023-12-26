//
//  Item.swift
//  Movie Today
//
//  Created by macbook on 26.12.2023.
//

import Foundation

struct Item: Hashable {
    var movieModel: MovieModel?
    var collectionMovie: Collection?
    var categories: String?
    let identifier = UUID()
}
