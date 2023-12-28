//
//  MovieListPresenter.swift
//  Movie Today
//
//  Created by macbook on 26.12.2023.
//

import Foundation
protocol MovieViewProtocol: AnyObject {
    func update()
    func reloadData()
    func animate(_ start: Bool)

}

protocol MovieListPresenterProtocol: AnyObject {
    var movies: [Doc]? { get set }
    var categories: [Categories] { get set }
    func didSelectItem(at indexPath: IndexPath)
    func getGenre(genre: MovieGenres)
    func updateController()
    init(view: MovieViewProtocol)
}


final class MovieListPresenter: MovieListPresenterProtocol {
    weak var view: MovieViewProtocol?

    var movies: [Doc]?
    var categories = [Categories(name: "Ужасы", isSelected: true),
                      Categories(name: "Комедия", isSelected: false),
                      Categories(name: "Криминал", isSelected: false),
                      Categories(name: "Драма", isSelected: false),
                      Categories(name: "Фантастика", isSelected: false),
                      Categories(name: "Мультфильм", isSelected: false),
                      Categories(name: "Документальный", isSelected: false)]   
    
    let networkManager = NetworkManager()

    func updateController() {
        getGenre(genre: .horror)
        DispatchQueue.main.async {
            self.view?.update()
        }
    }
    
    func getGenre(genre: MovieGenres) {
        networkManager.getMoviesGenre(genre: genre) { result in
            switch result {
            case .success(let movie):
                if self.movies == nil {
                    self.movies = [Doc]()
                }
                    self.movies = []
                self.movies?.append(contentsOf: movie.docs)
                    DispatchQueue.main.async {
                        self.view?.animate(false)
                        self.view?.update()
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

    
    
    init(view: MovieViewProtocol) {
        self.view = view
        self.view?.animate(true)
    }
}
