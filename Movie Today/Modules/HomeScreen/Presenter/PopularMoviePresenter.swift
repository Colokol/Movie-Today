//
//  PopularMoviePresenter.swift
//  Movie Today
//
//  Created by macbook on 26.12.2023.
//

import Foundation

protocol PopularMovieView: AnyObject {
    func update()
}

protocol PopularMoviePresenterProtocol: AnyObject {
    var array: [String] { get }
    func getMovie(with indexPath: IndexPath) -> String
    init(view: PopularMovieView)
}

final class PopularMoviePresenter: PopularMoviePresenterProtocol {
    weak var view: PopularMovieView?
    var array = ["Spider Man", "Spider Man", "Spider Man", "Spider Man", "Spider Man"]
    
    func getMovie(with indexPath: IndexPath) -> String {
        return array[indexPath.row]
    }

    init(view: PopularMovieView) {
        self.view = view
    }
}
