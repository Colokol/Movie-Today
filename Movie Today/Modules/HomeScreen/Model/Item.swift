//
//  Item.swift
//  Movie Today
//
//  Created by macbook on 26.12.2023.
//

import Foundation

struct Item: Hashable {
    var movieModel: Doc?
    var collectionMovie: Collection?
    var categories: Categories?
    let identifier = UUID()
}
