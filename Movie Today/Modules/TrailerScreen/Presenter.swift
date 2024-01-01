//
//  Presenter.swift
//  Movie Today
//
//  Created by macbook on 01.01.2024.
//

import Foundation

protocol TrailerViewProtocol: AnyObject {
    func update(with model: Doc, text: String)
}

protocol TrailerPresenterProtocol: AnyObject {
    init(view: TrailerViewProtocol, model: Doc, text: String)
    var model: Doc? { get set }
    var videoID: String? { get set }
    func config()
}

final class TrailerPresenter: TrailerPresenterProtocol {
    
    weak var view: TrailerViewProtocol?
    var model: Doc?
    var videoID: String?
    
    func config() {
        if let model = model, let id = videoID {
            self.view?.update(with: model, text: id)
        }
    }
    
    init(view: TrailerViewProtocol, model: Doc, text: String) {
        self.view = view
        self.model = model
        self.videoID = text
    }
    
    
}
