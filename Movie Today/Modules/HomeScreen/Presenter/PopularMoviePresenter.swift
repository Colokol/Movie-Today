//
//  PopularMoviePresenter.swift
//  Movie Today
//
//  Created by macbook on 26.12.2023.
//

import Foundation


protocol PopularMovieView: AnyObject {
    func update()
    func animate(_ start: Bool)
}

protocol PopularMoviePresenterProtocol: AnyObject {
    var array: [Doc]? { get set }
    var slug: String? { get set }
    func getMovie(with indexPath: IndexPath)
    func getPopular()
    func checkSlug()
    init(view: PopularMovieView, slug: String?)
}

final class PopularMoviePresenter: PopularMoviePresenterProtocol {
    weak var view: PopularMovieView?
    var slug: String?
    let networkManager = NetworkManager()
    var array: [Doc]?
    
    func getMovie(with indexPath: IndexPath) {
        
    }
    
    func getPopular() {
        networkManager.getMoviesFromCollection(collectionName: .popular) { result in
            switch result {
            case .success(let movie):
                if self.array == nil {
                    self.array = [Doc]()
                }
                self.array?.append(contentsOf: movie.docs)
                DispatchQueue.main.async {
                    self.view?.animate(false)
                    self.view?.update()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func getMovieFromSlug(slug: String) {
        networkManager.getMoviesFromCollection(collectionName: .collectionSlug(slug)) { result in
            switch result {
            case .success(let movie):
                if self.array == nil {
                    self.array = [Doc]()
                }
                let filteredMovie = movie.docs.filter { $0.poster != nil }
                self.array?.append(contentsOf: movie.docs)
                    DispatchQueue.main.async {
                        self.view?.animate(false)
                        self.view?.update()
                    }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func checkSlug() {
        if let slug = slug {
            getMovieFromSlug(slug: slug)
        } else {
            getPopular()
        }
        
    }
    
    init(view: PopularMovieView, slug: String?) {
        self.view = view
        self.slug = slug
        self.view?.animate(true)
    }
}
