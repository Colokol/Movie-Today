//
//  MovieListPresenter.swift
//  Movie Today
//
//  Created by macbook on 26.12.2023.
//

import Foundation
protocol MovieViewProtocol: AnyObject {
    func update()
}

protocol MovieListPresenterProtocol: AnyObject {
    var array2: [String] { get }
    var categories: [String] { get }
    func updateController()
    init(view: MovieViewProtocol)
}


final class MovieListPresenter: MovieListPresenterProtocol {
    weak var view: MovieViewProtocol?

    var array2 = ["Spider Man2", "Iron Man2", "Lord of the rings3", "Hobbit4", "Halk1"]
    var categories = ["All", "Fantasy", "Comedy", "Horror"]
    
    func updateController() {
        self.view?.update()
    }
    
    init(view: MovieViewProtocol) {
        self.view = view
    }
}
