//
//  RecentMoviePresenter.swift
//  Movie Today
//
//  Created by macbook on 09.01.2024.
//

import Foundation
protocol RecentMovieView: AnyObject {
    func update()
}

protocol RecentMoviePresenterProtocol: AnyObject {
    init(view: RecentMovieView)
    var recentMovies: [RecentMovie] { get set }
    func recentCount() -> Int
    func getMovieWithId(_ id: Int, completion: @escaping (Doc?) -> Void)
    func getFilmId(with indexPath: IndexPath) -> Int
}

final class RecentMoviePresenter: RecentMoviePresenterProtocol {
    weak var view: RecentMovieView?
    let networkMaganer = NetworkManager()
    let coreData = CoreDataManager.shared
    var recentMovies: [RecentMovie] = []
    
    init(view: RecentMovieView) {
        self.view = view
        loadFromCoreData()
    }
    
    private func loadFromCoreData() {
        coreData.loadRecentMovies { result in
            switch result {
            case .success(let movies):
                self.recentMovies = movies
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getMovieWithId(_ id: Int, completion: @escaping (Doc?) -> Void) {
        networkMaganer.searchMovieFor(id: id) { result in
            switch result {
            case .success(let movie):
                completion(movie)
            case .failure(let error):
                completion(nil)
                print(error.localizedDescription, "RecentPresenter")
            }
        }
    }
    
    func getFilmId(with indexPath: IndexPath) -> Int {
        let id = Int(recentMovies[indexPath.row].id)
        return id
    }
    
    func recentCount() -> Int {
        return recentMovies.count
    }
    
    
}
