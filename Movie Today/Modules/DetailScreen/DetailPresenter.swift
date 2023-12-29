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
    func configureScreen()
    init(view: DetailScreenViewProtocol, model: Doc)
}

final class DetailPresenter: DetailPresenterProtocol {

    

    weak var view: DetailScreenViewProtocol?

    var movies: Doc

    func configureScreen(){
        self.view?.update(model: self.movies )
    }


    init(view: DetailScreenViewProtocol, model: Doc) {
        self.view = view
        self.movies = model
    }

}
