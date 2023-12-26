//
//  Presenter.swift
//  Movie Today
//
//  Created by macbook on 25.12.2023.
//

import Foundation

protocol HomeScreenViewProtocol: AnyObject {
    func update()
    func reloadData()
}

protocol HomePresenterProtocol: AnyObject {
    var movies: [MovieModel]? { get }
    var collectionMovies: [CollectionMovieModel]? { get }
    var array: [String] { get }
    var array2: [String] { get }
    var categories: [String] { get set }
    func getCollectionMovie()
    func updateController()
    init(view: HomeScreenViewProtocol)
}

final class HomePresenter: HomePresenterProtocol {
    
    weak var view: HomeScreenViewProtocol?
    let networkManager = NetworkManager()
    
    var movies: [MovieModel]?
    var collectionMovies: [CollectionMovieModel]?
    var array = ["Spider Man", "Iron Man", "Lord of the rings", "Hobbit", "Halk"]
    var array2 = ["Spider Man2", "Iron Man2", "Lord of the rings3", "Hobbit4", "Halk1"]
    var categories: [String]
    
    func getGenre(genre: MovieGenres) {
        networkManager.getMoviesGenre(genre: genre) { result in
            switch result {
            case .success(let movie):
                print(movie)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getCollectionMovie() {
        networkManager.getCollectionMovie { result in
            print("ЗАПРОС ОТПРАВЛЕН")
            switch result {
            case .success(let movie):
                self.collectionMovies?.append(movie)
                print("МОДЕЛИ ДОБАВЛЕНЫ")
                self.view?.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
                print("ЧТО-ТО ПОШЛО НЕ ТАК")
            }
        }
    }
    
    func updateController() {
        self.view?.update()
    }
    
    
    init(view: HomeScreenViewProtocol) {
        self.view = view
        categories = MovieGenres.allCases.map { $0.rawValue }
        print(categories)
//        getGenre(genre: .carton)
    }
    
}
