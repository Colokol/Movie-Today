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

    static func createPopularMovieVC(slug: String?) -> UIViewController {
        let view = PopularMovieController()
        let presenter = PopularMoviePresenter(view: view, slug: slug)
        view.presenter = presenter
        return view
    }

    static func createSearchViewController() -> UIViewController {
        let view = SearchViewController()
        let presenter = SearchPresentor(view: view)
        view.presenter = presenter
        return view
    }

    static func createDetailVC(model:Doc) -> UIViewController {
        let view = DetailViewController()
        let presenter = DetailPresenter(view: view, model: model)
        view.hidesBottomBarWhenPushed = true
        view.presenter = presenter
        return view
    }

    static func createTrailerVC(model: Doc, id: String) -> UIViewController {
        let view = TrailerController()
        let presenter = TrailerPresenter(view: view, model: model, text: id)
        view.presenter = presenter
        return view
    }

    static func createWishListVC() -> UIViewController {
        let view = WishListVC()
        let presenter = WishListPresenter(view: view)
        view.presenter = presenter
        return view
    }

}
