//
//  DetailPresenter.swift
//  Movie Today
//
//  Created by Uladzislau Yatskevich on 29.12.23.
//

import Foundation

protocol DetailScreenViewProtocol: AnyObject {
    func update(model:Doc)
    func favoriteButtonTap()
}

protocol DetailPresenterProtocol: AnyObject {
    var movie: Doc { get set }
    var favoriteButtonState: Bool {get set}
    func configureScreen()
    func saveToFavorit()
    init(view: DetailScreenViewProtocol, model: Doc)
}

final class DetailPresenter: DetailPresenterProtocol {

    var favoriteButtonState: Bool = false
    var movie: Doc

    private let storageManager = CoreDataManager.shared

    weak var view: DetailScreenViewProtocol!

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

    func configureScreen(){
        view.update(model: movie )
    }


    func saveToFavorit() {
        favoriteButtonState.toggle()
        
        if favoriteButtonState {
            storageManager.saveToFavorites(from: movie)
            view?.favoriteButtonTap()
        } else {
            storageManager.removeFromFavorites(model: movie)
            view?.favoriteButtonTap()

        }
    }



}
