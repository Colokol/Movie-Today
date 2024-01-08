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
    func updateActors(_ actors: [Person])
}

protocol SearchPresentorProtocol: AnyObject {
    init(view: SearchViewProtocol)
    var searchMovies: [Doc]? { get set }
    var movies: [Doc]? { get set }
    var moviesTwo: [Doc]? { get set }
    var categories: [Categories] { get set }
    var actors: [Person]? { get set }
    func getUpcomingMovie()
    func getFilms(with text: String)
    func getActors(with: [Person])
    func didSelectItem(at: IndexPath)
}

final class SearchPresentor: SearchPresentorProtocol {

    
    
    weak var view: SearchViewProtocol?
    let networkManager = NetworkManager()
    var searchMovies: [Doc]?
    var movies: [Doc]?
    var moviesTwo: [Doc]?
    var categories = [Categories(name: "Ужасы", isSelected: true),
                          Categories(name: "Комедия", isSelected: false),
                          Categories(name: "Криминал", isSelected: false),
                          Categories(name: "Драма", isSelected: false),
                          Categories(name: "Фантастика", isSelected: false),
                          Categories(name: "Мультфильм", isSelected: false),
                          Categories(name: "Документальный", isSelected: false)]
    var actors: [Person]?
    
    
    init(view: SearchViewProtocol) {
        self.view = view
    }
    
    func getUpcomingMovie() {
        networkManager.getMoviesFromCollection(collectionName: .popular) { result in
            switch result {
            case .success(let movie):
                if self.movies == nil && self.moviesTwo == nil {
                    self.movies = [Doc]()
                    self.moviesTwo = [Doc]()
                }
                self.movies = movie.docs
                self.moviesTwo = movie.docs
                DispatchQueue.main.async {
                    self.view?.updateData()
                    self.view?.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getFilms(with text: String) {
        networkManager.searchMovie(searchText: text) { [weak self] result in
            switch result {
            case .success(let movie):
                print(movie.docs[0].persons)
                if self?.searchMovies == nil {
                    self?.searchMovies = [Doc]()
                }
                let filteredMovies = movie.docs.filter {
                    $0.id != nil
                    && $0.ageRating != nil
                    && $0.genres != nil
                    && $0.movieLength != nil
                    && $0.name != nil
                    && $0.poster != nil
                    && $0.rating != nil
                    && $0.type != nil
                    && $0.year != nil
                }
                self?.searchMovies = filteredMovies
                print(filteredMovies[0].persons)
                if filteredMovies.count == 0 {
                    self?.view?.updateSearchResults(filteredMovies, hideError: false)
                } else {
                    self?.view?.updateSearchResults(filteredMovies, hideError: true)
                    for person in filteredMovies {
                        guard let actors = person.persons else { return }
                        print(actors)
                        self?.getActors(with: actors)
                    }

                }
            case .failure(let error):
                print(error.localizedDescription, "Данных нет")
            }
        }
    }
    
    func getActors(with: [Person]) {
        let actor = with
        if self.actors == nil {
            self.actors = [Person]()
        }
        self.actors = actor
        print("актеры получены")
        guard let actors = self.actors else { return }
        self.view?.updateActors(actors)
        print("актеры отданы")

    }
    
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


}
