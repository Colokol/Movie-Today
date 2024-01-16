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

    static func createPopularMovieVC(slug: String?, collectionName: String?) -> UIViewController {
        let view = PopularMovieController()
        let presenter = PopularMoviePresenter(view: view, slug: slug, collectionName: collectionName)
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

    static func createSearchResultController(person: [PersonModel]?, movie: [Doc]?) -> SearchResultController {
        let view = SearchResultController()
        let presenter = SearchResultPresenter(view: view, actors: person, movies: movie)
        view.presenter = presenter
        return view
    }
    
    static func createHomeSearchResultVC(model: [Doc]?) -> SearchResult {
        let view = SearchResult()
        let presenter = ResultPresenter(view: view, model: model)
        view.presenter = presenter
        return view
    }
 

    static func createWishListVC() -> UIViewController {
        let view = WishListVC()
        let presenter = WishListPresenter(view: view)
        view.presenter = presenter
        return view
    }

    static func createTabBarViewController() -> UIViewController {
        return TabBarController()
    }

    static func createRecentController() -> UIViewController {
        let view = RecentMovieController()
        let presenter = RecentMoviePresenter(view: view)
        view.presenter = presenter
        return view
    }

    static func createOnboardingViewController() -> UIViewController {
        let vc = OnboardingViewController()
        let presenter = OnboardingPresenter(view: vc)
        vc.presenter = presenter
        return vc
    }
    
    static func createTreeController() -> UIViewController {
        let vc = TreeViewController()
        let presenter = TreePresenter(view: vc)
        vc.presenter = presenter
        return vc
    }


}
