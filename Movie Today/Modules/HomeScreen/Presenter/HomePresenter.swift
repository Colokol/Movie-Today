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
    func animate(_ start: Bool)
    func updateSearchResults(_ movies: [DocSearch])
}

protocol HomePresenterProtocol: AnyObject {
    var movies: [Doc]? { get set }
    var collectionMovies: [Collection]? { get set }
    var categories: [Categories] { get set }
    var searchMovies: [DocSearch]? { get set }
    func getCollectionMovie()
    func getMoviesFromCollection()
    func updateController()
    func getFilms(with text: String)
    func didSelectItem(at indexPath: IndexPath)
    init(view: HomeScreenViewProtocol)
}

final class HomePresenter: HomePresenterProtocol {
    
    weak var view: HomeScreenViewProtocol?
    let networkManager = NetworkManager()
    
    var movies: [Doc]?
    var collectionMovies: [Collection]?
    var searchMovies: [DocSearch]?
    var categories = [Categories(name: "Ужасы", isSelected: true),
                      Categories(name: "Комедия", isSelected: false),
                      Categories(name: "Криминал", isSelected: false),
                      Categories(name: "Драма", isSelected: false),
                      Categories(name: "Фантастика", isSelected: false),
                      Categories(name: "Мультфильм", isSelected: false),
                      Categories(name: "Документальный", isSelected: false)]
    
    func getGenre(genre: MovieGenres) {
        networkManager.getMoviesGenre(genre: genre) { result in
            switch result {
            case .success(let movie):
                if self.movies == nil {
                    self.movies = [Doc]()
                } else {
                    self.movies = []
                    self.movies?.append(contentsOf: movie.docs)
                    DispatchQueue.main.async {
                        self.view?.animate(false)
                        self.view?.update()
                        self.view?.reloadData()
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getCollectionMovie() {
        networkManager.getCollectionMovie { result in
            switch result {
            case .success(let movie):
                if self.collectionMovies == nil {
                    self.collectionMovies = [Collection]()
                }
                self.collectionMovies?.append(contentsOf: movie.docs)
                DispatchQueue.main.async {
                    self.view?.update()
                    self.view?.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    func getMoviesFromCollection() {
        networkManager.getMoviesFromCollection(collectionName: .popular) { result in
            switch result {
            case .success(let movie):
                if  self.movies == nil {
                    self.movies = [Doc]()
                }
                self.movies?.append(contentsOf: movie.docs)
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
            for i in 0..<categories.count {
                categories[i].isSelected = false
            }
            categories[indexPath.row].isSelected = !categories[indexPath.row].isSelected
        self.movies = []
        self.view?.update()
        self.view?.animate(true)
        
        let selectedModel = categories[indexPath.row]
        switch selectedModel.name {
        case "Ужасы":
            getGenre(genre: .horror)
        case "Комедия":
            getGenre(genre: .comedy)
        case "Криминал":
            getGenre(genre: .criminal)
        case "Драма":
            getGenre(genre: .drama)
        case "Фантастика":
            getGenre(genre: .fantasy)
        case "Мультфильм":
            getGenre(genre: .carton)
        case "Документальный":
            getGenre(genre: .documentary)
        default:
            break
        }
    }
    
    func getFilms(with text: String) {
        print("запрос ушел с текстом \(text)")
        networkManager.searchMovie(searchText: text) { [weak self] result in
            switch result {
            case .success(let movie):
                if self?.searchMovies == nil {
                    self?.searchMovies = [DocSearch]()
                }
                self?.searchMovies = movie.docs
                self?.view?.updateSearchResults(movie.docs)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    init(view: HomeScreenViewProtocol) {
        self.view = view
    }
    
}
