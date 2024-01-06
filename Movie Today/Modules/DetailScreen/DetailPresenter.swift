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
    var id: String? { get set }
 	func configureScreen()
    func saveToFavorit()
    init(view: DetailScreenViewProtocol, model: Doc)
}

final class DetailPresenter: DetailPresenterProtocol {

    weak var view: DetailScreenViewProtocol?
    let youtubeManager = YouTubeManager()
    var movie: Doc
    var id: String?

    func configureScreen(){
        self.view?.update(model: self.movie )
    }
    
    func fetchVideoID() {
        youtubeManager.fetchData(query: movie.name + "film trailer") { result in
            switch result {
            case .success(let model):
                if self.id == nil {
                    self.id = ""
                }
                self.id = model.items[0].id.videoId
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

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
        fetchVideoID()

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
