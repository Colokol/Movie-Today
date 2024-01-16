//
//  TreePresenter.swift
//  Movie Today
//
//  Created by macbook on 15.01.2024.
//

import Foundation

protocol TreeViewProtocol: AnyObject {
    func update(with model: Doc)
}

protocol TreePresenterProtocol: AnyObject {
    var movie: Doc? { get set }
    func getFilm()
    init(view: TreeViewProtocol)
}

final class TreePresenter: TreePresenterProtocol {
    weak var view: TreeViewProtocol?
    let networkManager = NetworkManager()
    var movie: Doc?
    
    func getFilm() {
        networkManager.getMoviesFromCollection(collectionName: .popular) { result in
            switch result {
            case .success(let movie):
                guard let movie = movie.docs.randomElement() else { return }
                self.movie = movie
                DispatchQueue.main.async {
                    self.view?.update(with: movie)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    init(view: TreeViewProtocol) {
        self.view = view
    }
    
    
}
