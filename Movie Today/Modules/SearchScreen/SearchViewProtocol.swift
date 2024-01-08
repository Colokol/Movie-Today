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
}

protocol SearchPresentorProtocol: AnyObject {
    init(view: SearchViewProtocol)
    var movies: [Doc]? { get set }
    var moviesTwo: [Doc]? { get set }
    var categories: [Categories] { get set }
    func getUpcomingMovie()
}

final class SearchPresentor: SearchPresentorProtocol {
    
    weak var view: SearchViewProtocol?
    let networkManager = NetworkManager()
    var movies: [Doc]?
    var moviesTwo: [Doc]?
    var categories = [Categories(name: "Ужасы", isSelected: true),
                          Categories(name: "Комедия", isSelected: false),
                          Categories(name: "Криминал", isSelected: false),
                          Categories(name: "Драма", isSelected: false),
                          Categories(name: "Фантастика", isSelected: false),
                          Categories(name: "Мультфильм", isSelected: false),
                          Categories(name: "Документальный", isSelected: false)]
    
    
    init(view: SearchViewProtocol) {
        self.view = view
    }
    
    func getUpcomingMovie() {
        print("Запрос пошел")
        networkManager.getMoviesFromCollection(collectionName: .popular) { result in
            switch result {
            case .success(let movie):
                if self.movies == nil && self.moviesTwo == nil {
                    self.movies = [Doc]()
                    self.moviesTwo = [Doc]()
                }
                self.movies = movie.docs
                self.moviesTwo = movie.docs
                print("Запрос пришел")
                DispatchQueue.main.async {
                    self.view?.updateData()
                    self.view?.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
