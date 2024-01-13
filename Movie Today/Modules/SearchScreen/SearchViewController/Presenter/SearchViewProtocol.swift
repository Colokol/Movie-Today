//
//  SearchPresentor.swift
//  Movie Today
//
//  Created by Nikita on 29.12.2023.
//

import Foundation

protocol SearchViewProtocol: AnyObject {
    func updateData()
    func reloadData()
    func animate(_ bool: Bool)
    func hideError(hide: Bool)
    func updateSearchResults(_ movies: [Doc], hideError: Bool)
    func updateActors(_ actors: [PersonModel])
}

protocol SearchPresentorProtocol: AnyObject {
    init(view: SearchViewProtocol)
    var searchMovies: [Doc]? { get set }
    var movies: [Doc]? { get set }
    var moviesTwo: [Doc]? { get set }
    var categories: [Categories] { get set }
    var actors: [PersonModel]? { get set }
    var recentMovies: [RecentMovie] { get set }
    func getUpcomingMovie()
    func getFilms(with text: String)
    func getActorsWithName(_ name: String)
    func getMovieForActordID(with id: Int)
    func didSelectItem(at: IndexPath)
    func loadRecenMovie()
    func saveToCoreData(model: Doc)
    func getFilm(with id: Int, completion: @escaping (Doc?) -> Void)
    func updateData()
    func reloadData()
}

final class SearchPresentor: SearchPresentorProtocol {
    //MARK: - Properties
    weak var view: SearchViewProtocol?
    let coreData = CoreDataManager.shared
    let networkManager = NetworkManager()
    var searchMovies: [Doc]?
    var movies: [Doc]?
    var moviesTwo: [Doc]?
    var recentMovies: [RecentMovie] = []
    var categories = [Categories(name: "Ужасы", isSelected: true),
                      Categories(name: "Комедия", isSelected: false),
                      Categories(name: "Криминал", isSelected: false),
                      Categories(name: "Драма", isSelected: false),
                      Categories(name: "Фантастика", isSelected: false),
                      Categories(name: "Мультфильм", isSelected: false),
                      Categories(name: "Документальный", isSelected: false)]
    var actors: [PersonModel]?
    
    
    //MARK: - Init
    init(view: SearchViewProtocol) {
        self.view = view
        loadRecenMovie()
    }
    
    func updateData() {
        self.view?.updateData()
    }
    func reloadData() {
        self.view?.reloadData()
    }
    //MARK: - UpcomingMovie
    func getUpcomingMovie() {
        networkManager.getMoviesFromCollection(collectionName: .popular) { result in
            switch result {
            case .success(let movie):
                if self.movies == nil && self.moviesTwo == nil {
                    self.movies = [Doc]()
                }
                self.movies = movie.docs
                DispatchQueue.main.async {
                    self.view?.updateData()
                    self.view?.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    //MARK: - SearchBar method for movies
    func getFilms(with text: String) {
        networkManager.searchMovie(searchText: text) { [weak self] result in
            switch result {
            case .success(let movie):
                if self?.moviesTwo == nil {
                    self?.moviesTwo = [Doc]()
                }
                let filteredMovies = movie.docs.filter { $0.poster?.url?.isEmpty == false }
                self?.moviesTwo = filteredMovies
                if filteredMovies.count == 0 {
                    self?.view?.updateSearchResults(filteredMovies, hideError: false)
                } else {
                    self?.view?.updateSearchResults(filteredMovies, hideError: true)
                }
            case .failure(let error):
                print(error.localizedDescription, "Данных нет")
            }
        }
    }
    //MARK: - SearchBar method for actors
    func getActorsWithName(_ name: String) {
        networkManager.searchPerson(searchText: name) { result in
            switch result {
            case .success(let actors):
                if self.actors == nil {
                    self.actors = [PersonModel]()
                }
                let filteredActors = Array(actors.docs.filter { $0.photo?.isEmpty == false }.prefix(3))
                print(filteredActors)
                self.actors = filteredActors
                self.view?.updateActors(filteredActors)
                self.getMovieForActordID(with: filteredActors[0].id)
                
            case .failure(let error):
                print(error.localizedDescription, "Ошибка в getActorsWithName")
            }
        }
    }
    //MARK: - SearchBar method for search films with actor id
    func getMovieForActordID(with id: Int) {
        networkManager.getMovieFor(personId: id) { result in
            switch result {
            case .success(let movie):
                if self.searchMovies == nil {
                    self.searchMovies = [Doc]()
                } else {
                    self.searchMovies?.removeAll()
                }
                let filteredMovie = movie.docs.filter { $0.poster?.url?.isEmpty == false }
                self.searchMovies = filteredMovie
                self.view?.updateSearchResults(filteredMovie, hideError: true)
            case .failure(let error):
                print(error.localizedDescription, "Ошибка в getMovieForActordID")
            }
        }
    }
    //MARK: - Switch genre method
    func getGenre(genre: MovieGenres) {
        self.view?.animate(true)
        networkManager.getMoviesGenre(genre: genre) { result in
            switch result {
            case .success(let movie):
                if self.movies == nil {
                    self.movies = [Doc]()
                } else {
                    self.movies?.removeAll()
                }
                self.movies = movie.docs
                DispatchQueue.main.async {
                    self.view?.animate(false)
                    self.view?.updateData()
                    self.view?.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    //MARK: - CollectionView Delegate
    func didSelectItem(at indexPath: IndexPath) {
        for i in 0..<categories.count {
            categories[i].isSelected = false
        }
        categories[indexPath.row].isSelected = !categories[indexPath.row].isSelected
        self.view?.updateData()
        
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
    //MARK: - CoreData Methods
    func loadRecenMovie() {
        coreData.loadRecentMovies { result in
            switch result {
            case .success(let movie):
                self.recentMovies = movie
                self.recentMovies = self.recentMovies.reversed()
            case .failure(let error):
                print(error.localizedDescription, "Error in loadRecenMovie")
            }
        }
    }
    func saveToCoreData(model: Doc) {
        coreData.saveToRecent(from: model)
    }
    
    //MARK: - DetailScreen Methods
    func getFilm(with id: Int, completion: @escaping (Doc?) -> Void) {
        networkManager.searchMovieFor(id: id) { result in
            switch result {
            case .success(let movie):
                completion(movie)
            case .failure(let error):
                print(error.localizedDescription, "Ошибка в searchresultpresenter getFilmID")
                completion(nil)
            }
        }
    }
    
    
}
