//
//  WishListPresenter.swift
//  Movie Today
//
//  Created by Uladzislau Yatskevich on 6.01.24.
//

import Foundation

protocol WishListViewProtocol {
    func update()
    func changeHeartColor()
}

protocol WishListPresenterProtocol {
    var favoriteMovies: [FavoriteMovies] {get set}
    func likePressed(_ favoriteMovie: FavoriteMovies)
    func getMovie(with id: Int, completion: @escaping (Doc?) -> Void)
}

class WishListPresenter: WishListPresenterProtocol {
    
    let storageManager = CoreDataManager.shared
    let networkManager = NetworkManager()

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
    
    func getMovie(with id: Int, completion: @escaping (Doc?) -> Void) {
        networkManager.searchMovieFor(id: id) { result in
            switch result {
            case .success(let movie):
                completion(movie)
            case .failure(let error):
                completion(nil)
                print(error.localizedDescription)
            }
        }
    }

     func likePressed(_ favoriteMovie: FavoriteMovies) {
        storageManager.deleteFromFavorites(favoriteMovie)
        loadMovies()
    }

}


