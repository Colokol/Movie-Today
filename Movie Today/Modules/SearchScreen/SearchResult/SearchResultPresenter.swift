//
//  SearchResultPresenter.swift
//  Movie Today
//
//  Created by macbook on 05.01.2024.
//

import Foundation

protocol SearchResultViewProtocol: AnyObject {
    func update()
    func reloadData()
    func showError(_ show: Bool)
}

protocol SearchResultPresenterProtocol: AnyObject {
    init(view: SearchResultViewProtocol, actors: [Person]?, movies: [DocSearch]?)
    var actors: [Person]? { get set }
    var movies: [DocSearch]? { get set }
    var personInfo: [PersonModel]? { get set }
    func updateModels()
    func reloadData()
    func showError(_ show: Bool)
//    func getActorInfo(with id: Int)
}

final class SearchResultPresenter: SearchResultPresenterProtocol {
    
    //MARK: - Properties
    weak var view: SearchResultViewProtocol?
    var actors: [Person]?
    var movies: [DocSearch]?
    var personInfo: [PersonModel]?
    let networkManager = NetworkManager()
    
    //MARK: - Methods
    func updateModels() {
        self.view?.update()
    }
    func reloadData() {
        self.view?.reloadData()
    }
    func showError(_ show: Bool) {
        self.view?.showError(show)
    }
//    
//    func getActorInfo(with id: Int) {
//        networkManager.searchPersonInfo(id: id) { result in
//            switch result {
//            case .success(let actor):
//                if self.personInfo == nil {
//                    self.personInfo = [PersonModel]()
//                }
//                self.personInfo?.append(actor)
//                self.view?.update()
//                self.view?.reloadData()
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
    
    func getFilmsFromActor(with id: Int) {
        //MARK: - ТУТ ПОИСК ФИЛЬМА ПО ID
        
    }
    
    //MARK: - Init
    init(view: SearchResultViewProtocol, actors: [Person]?, movies: [DocSearch]?) {
        self.view = view
        self.actors = actors
        self.movies = movies
        
        
    }
}
