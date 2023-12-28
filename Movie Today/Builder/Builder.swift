//
//  Builder.swift
//  Movie Today
//
//  Created by macbook on 25.12.2023.
//

import UIKit

final class Builder {
    private init() {}
    
    static func createHomeVC() -> UIViewController {
        let view = HomeViewController()
        let presenter = HomePresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    static func createMovieListVC() -> UIViewController {
        let view = MovieListController()
        let presenter = MovieListPresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    static func createPopularMovieVC() -> UIViewController {
        let view = PopularMovieController()
        let presenter = PopularMoviePresenter(view: view)
        view.presenter = presenter
        return view
    }
}
