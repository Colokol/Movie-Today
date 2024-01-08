//
//  Presenter.swift
//  Movie Today
//
//  Created by macbook on 01.01.2024.
//

import Foundation

protocol TrailerViewProtocol: AnyObject {
    func update(with model: Doc)
    func updateActors()
}

protocol TrailerPresenterProtocol: AnyObject {
    init(view: TrailerViewProtocol, model: Doc)
    var model: Doc? { get set }
    var filmPersons: [Person]? { get set }
    func config()
    func getActors()
}

final class TrailerPresenter: TrailerPresenterProtocol {
    
    weak var view: TrailerViewProtocol?
    var model: Doc?
    var filmPersons: [Person]?
    let networkManager = NetworkManager()
    
    func config() {
        if let model = model {
            self.view?.update(with: model)
        }
    }
    
    func getActors() {
        guard let model else { return }
        if filmPersons == nil {
            filmPersons = [Person]()
        }
        guard let presons = model.persons else { return }
        for i in 0..<4 {
            self.filmPersons?.append(presons[i])
        }
    }
    
    init(view: TrailerViewProtocol, model: Doc) {
        self.view = view
        self.model = model
    }
    
    
}
