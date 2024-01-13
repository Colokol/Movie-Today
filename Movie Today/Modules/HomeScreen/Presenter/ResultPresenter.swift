//
//  ResultPresenter.swift
//  Movie Today
//
//  Created by macbook on 10.01.2024.
//

import Foundation
protocol ResultViewProtocol: AnyObject {
    func update()
    func reloadData()
    func showError(_ show: Bool)
}

protocol ResultPresenterProtocol: AnyObject {
    var results: [Doc]? { get set }
    func reloadData()
    func showError(_ show: Bool)
    func update()
    init(view: ResultViewProtocol?, model: [Doc]?)
}

final class ResultPresenter: ResultPresenterProtocol {
    
    var results: [Doc]?
    
    weak var view: ResultViewProtocol?
    
    func reloadData() {
        self.view?.reloadData()
    }
    
    func showError(_ show: Bool) {
        self.view?.showError(show)
    }
    
    func update() {
        self.view?.update()
    }
    init(view: ResultViewProtocol?, model: [Doc]?) {
        self.view = view
        self.results = model
    }
    
    
}
