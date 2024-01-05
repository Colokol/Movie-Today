//
//  DetailPresenter.swift
//  Movie Today
//
//  Created by Uladzislau Yatskevich on 29.12.23.
//

import Foundation

protocol DetailScreenViewProtocol: AnyObject {
    func update(model:Doc)
}

protocol DetailPresenterProtocol: AnyObject {
    var movies: Doc { get set }
    var id: String? { get set }
    func configureScreen()
    init(view: DetailScreenViewProtocol, model: Doc)
}

final class DetailPresenter: DetailPresenterProtocol {

    weak var view: DetailScreenViewProtocol?
    let youtubeManager = YouTubeManager()
    var movies: Doc
    var id: String?

    func configureScreen(){
        self.view?.update(model: self.movies )
    }
    
    func fetchVideoID() {
        youtubeManager.fetchData(query: movies.name + "film trailer") { result in
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


    init(view: DetailScreenViewProtocol, model: Doc) {
        self.view = view
        self.movies = model
        fetchVideoID()
    }

}
