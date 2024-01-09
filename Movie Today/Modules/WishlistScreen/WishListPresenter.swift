//
//  WishListPresenter.swift
//  Movie Today
//
//  Created by Uladzislau Yatskevich on 6.01.24.
//

import Foundation

protocol WishListViewProtocol {
    func update()
}

protocol WishListPresenterProtocol {
    var favoriteMovies: [FavoriteMovies] {get set}
    func likePressed(_ favoriteMovie: FavoriteMovies)
}

class WishListPresenter: WishListPresenterProtocol {
    
    let storageManager = CoreDataManager.shared

    var favoriteMovies: [FavoriteMovies] = []

    var view:WishListViewProtocol?

    init(view: WishListViewProtocol) {
        self.view = view
        self.loadMovies()
    }


    private func loadMovies() {
        storageManager.loadFavoriteMovies { result in
            switch result{
                case .success(let movies):
                    favoriteMovies = movies
                    view?.update()
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }

     func likePressed(_ favoriteMovie: FavoriteMovies) {
        storageManager.deleteFromFavorites(favoriteMovie)
        loadMovies()
    }

}


