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
    var movies: [MovieModel]? { get set }
    var collectionMovies: [CollectionMovieModel]? { get set }
    var categories: [String] { get set }
    func getCollectionMovie()
    func getMoviesFromCollection()
    func updateController()
    func didSelectItem(at indexPath: IndexPath)
    init(view: HomeScreenViewProtocol)
}

final class HomePresenter: HomePresenterProtocol {
    
    weak var view: HomeScreenViewProtocol?
    let networkManager = NetworkManager()
    
    var movies: [MovieModel]?
    var collectionMovies: [CollectionMovieModel]?
    var categories = MovieGenres.allCases.map { $0.rawValue }
    
    func getGenre(genre: MovieGenres) {
        networkManager.getMoviesGenre(genre: genre) { result in
            switch result {
            case .success(let movie):
                if self.movies == nil {
                    self.movies = [MovieModel]()
                } else {
                    self.movies = []
                    self.movies?.append(movie)
                    print("--------------------Модели в getGenre добавлены---------------------")
                    DispatchQueue.main.async {
                        self.view?.update()
                        self.view?.reloadData()
                    }
                }
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
                if self.collectionMovies == nil {
                    self.collectionMovies = [CollectionMovieModel]()
                }
                self.collectionMovies?.append(movie)
                print(self.collectionMovies)
                print("МОДЕЛИ ДОБАВЛЕНЫ")
                DispatchQueue.main.async {
                    self.view?.update()
                    self.view?.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
                print("ЧТО-ТО ПОШЛО НЕ ТАК")
            }
        }
        
    }
    
    func getMoviesFromCollection() {
        networkManager.getMoviesFromCollection(collectionName: .popular) { result in
            print("Запрос на популярные фильмы отправлен")
            switch result {
            case .success(let movie):
                if  self.movies == nil {
                    self.movies = [MovieModel]()
                }
                self.movies?.append(movie)
                print("Добавлены фильмы", self.movies)
                DispatchQueue.main.async {
                    self.view?.update()
                    self.view?.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription, "ERROR")
            }
        }
    }
    
    func updateController() {
        self.view?.update()
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        let selectedModel = categories[indexPath.row]
        switch selectedModel {
        case "ужасы":
            getGenre(genre: .horror)
        case "комедия":
            getGenre(genre: .comedy)
        case "криминал":
            getGenre(genre: .criminal)
        case "драма":
            getGenre(genre: .drama)
        case "фантастика":
            getGenre(genre: .fantasy)
        case "мультфильм":
            getGenre(genre: .carton)
        case "документальный":
            getGenre(genre: .documentary)
        default:
            break
        }
    }
    
    init(view: HomeScreenViewProtocol) {
        self.view = view
    }
    
}
