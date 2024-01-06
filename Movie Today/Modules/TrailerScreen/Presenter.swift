//
//  Presenter.swift
//  Movie Today
//
//  Created by macbook on 01.01.2024.
//

import Foundation

protocol TrailerViewProtocol: AnyObject {
    func update(with model: Doc, text: String)
    func updateActors()
}

protocol TrailerPresenterProtocol: AnyObject {
    init(view: TrailerViewProtocol, model: Doc, text: String)
    var model: Doc? { get set }
    var videoID: String? { get set }
    var filmPersons: [Person]? { get set }
    func config()
    func getActors()
}

final class TrailerPresenter: TrailerPresenterProtocol {
    
    weak var view: TrailerViewProtocol?
    var model: Doc?
    var videoID: String?
    var filmPersons: [Person]?
    let networkManager = NetworkManager()
    
    func config() {
        if let model = model, let id = videoID {
            self.view?.update(with: model, text: id)
        }
    }
    
    func getActors() {
        guard let model else { return }
        networkManager.getPersonForMovie(id: model.id) { result in
            switch result {
            case .success(let actor):
                if self.filmPersons == nil {
                    self.filmPersons = [Person]()
                }
                self.filmPersons?.append(contentsOf: actor.docs)
                DispatchQueue.main.async {
                    self.view?.updateActors()
                }
            case .failure(let error):
                print(error.localizedDescription, "TrailerPresenterError")
            }
        }
    }
    
    init(view: TrailerViewProtocol, model: Doc, text: String) {
        self.view = view
        self.model = model
        self.videoID = text
    }
    
    
}
