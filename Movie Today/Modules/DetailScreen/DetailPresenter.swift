//
//  DetailPresenter.swift
//  Movie Today
//
//  Created by Uladzislau Yatskevich on 29.12.23.
//

import Foundation

protocol DetailScreenViewProtocol: AnyObject {
    func update(model: Doc)
    func updateActors()
}

protocol DetailPresenterProtocol: AnyObject {
    var movie: Doc { get set }
    var favoriteButtonState: Bool { get set }
    var filmPersons: [Person]? { get set }
    
    func configureScreen()
    func saveToFavorit()
    func getActors()
    init(view: DetailScreenViewProtocol, model: Doc)
}

final class DetailPresenter: DetailPresenterProtocol {
    var favoriteButtonState: Bool = false
    var movie: Doc
    var filmPersons: [Person]?
    let storageManager = CoreDataManager.shared
    weak var view: DetailScreenViewProtocol!

    func configureScreen(){
        self.view?.update(model: self.movie)
    }

    func saveToFavorit() {
        favoriteButtonState.toggle()

        if favoriteButtonState {
            storageManager.saveToFavorites(from: movie)
        } else {
            storageManager.removeFromFavorites(model: movie)
        }
    }

    func getActors() {
        if filmPersons == nil {
            filmPersons = [Person]()
        }
        guard let persons = movie.persons else { return }
        for i in 0..<5 {
            self.filmPersons?.append(persons[i])
        }
    }

    init(view: DetailScreenViewProtocol, model: Doc) {
        self.view = view
        self.movie = model

        storageManager.loadFavoriteMovies { result in
            if case .success(let favoriteMovies) = result {
                favoriteMovies.forEach {
                    if $0.name == movie.name {
                        favoriteButtonState = true
                    }
                }
            }
        }
    }
}
