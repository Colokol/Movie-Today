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
    init(view: SearchResultViewProtocol, actors: [PersonModel]?, movies: [Doc]?)
    var actors: [PersonModel]? { get set }
    var movies: [Doc]? { get set }
    var recentMovies: [Doc]? { get set }
    var personInfo: [PersonModel]? { get set }
    var movie: Doc? { get set }
    func updateModels()
    func reloadData()
    func showError(_ show: Bool)
    func getFilm(with id: Int, completion: @escaping (Doc?) -> Void)
    func saveToCoreData(model: Doc)
}

final class SearchResultPresenter: SearchResultPresenterProtocol {
    
    //MARK: - Properties
    weak var view: SearchResultViewProtocol?
    var actors: [PersonModel]?
    var movies: [Doc]?
    var recentMovies: [Doc]?
    var personInfo: [PersonModel]?
    var movie: Doc?
    let networkManager = NetworkManager()
    let coreData = CoreDataManager.shared
    
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
 
    func saveToCoreData(model: Doc) {
        coreData.saveToRecent(from: model)
    }
    
    
    func getFilm(with id: Int, completion: @escaping (Doc?) -> Void) {
        networkManager.searchMovieFor(id: id) { result in
            switch result {
            case .success(let movie):
                self.movie = movie
                completion(movie)
            case .failure(let error):
                print(error.localizedDescription, "Ошибка в searchresultpresenter getFilmID")
                completion(nil)
            }
        }
    }
    
    
    //MARK: - Init
    init(view: SearchResultViewProtocol, actors: [PersonModel]?, movies: [Doc]?) {
        self.view = view
        self.actors = actors
        self.movies = movies
        
        
    }
}
