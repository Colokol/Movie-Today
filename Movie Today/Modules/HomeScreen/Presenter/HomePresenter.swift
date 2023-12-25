//
//  Presenter.swift
//  Movie Today
//
//  Created by macbook on 25.12.2023.
//

import Foundation

protocol HomeScreenViewProtocol: AnyObject {
    func update()
}

protocol HomePresenterProtocol: AnyObject {
    var array: [String] { get }
    var array2: [String] { get }
    var categories: [String] { get }
    func updateController()
    init(view: HomeScreenViewProtocol)
}

final class HomePresenter: HomePresenterProtocol {
    
     weak var view: HomeScreenViewProtocol?
    
     var array = ["Spider Man", "Iron Man", "Lord of the rings", "Hobbit", "Halk"]
     var array2 = ["Spider Man2", "Iron Man2", "Lord of the rings3", "Hobbit4", "Halk1"]
     var categories = ["All", "Fantasy", "Comedy", "Horror"]
    
    func updateController() {
        self.view?.update()
    }
   

    init(view: HomeScreenViewProtocol) {
        self.view = view
    }
    
}
