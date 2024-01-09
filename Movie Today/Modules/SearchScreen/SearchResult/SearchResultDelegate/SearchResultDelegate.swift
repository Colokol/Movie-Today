//
//  SearchResultDelegate.swift
//  Movie Today
//
//  Created by macbook on 08.01.2024.
//

import Foundation

protocol SearchResultDelegate: AnyObject {
    func openDetailWithModel(_ model: Doc)
}
