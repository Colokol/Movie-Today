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

}

protocol MovieListPresenterProtocol: AnyObject {
    var movies: [MovieModel]? { get set }
    var categories: [String] { get set }
    func didSelectItem(at indexPath: IndexPath)
    func getGenre(genre: MovieGenres)
    func updateController()
    init(view: MovieViewProtocol)
}


final class MovieListPresenter: MovieListPresenterProtocol {
    weak var view: MovieViewProtocol?

    var movies: [MovieModel]?
    var categories = MovieGenres.allCases.map { $0.rawValue }
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
                    self.movies = [MovieModel]()
                }
                    self.movies = []
                    self.movies?.append(movie)
                    print("--------------------Модели в getGenre добавлены---------------------")
                    DispatchQueue.main.async {
                        self.view?.update()
                        self.view?.reloadData()
                    }
                
                print(movie)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        let selected = categories[indexPath.row]
        switch selected {
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
    
    init(view: MovieViewProtocol) {
        self.view = view
    }
}
