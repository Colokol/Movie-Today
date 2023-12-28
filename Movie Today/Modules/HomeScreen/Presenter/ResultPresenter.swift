//
//  ResultPresenter.swift
//  Movie Today
//
//  Created by macbook on 28.12.2023.
//

//import Foundation
//
//protocol SearchResultView: AnyObject {
//    func update()
//}
//
//protocol ResultPresenterProtocol: AnyObject {
//    var array: [Doc]? { get set }
//    init(view: SearchResultView, text: String)
//}
//
//final class ResultPresenter: ResultPresenterProtocol {
//    weak var view: SearchResultView?
//    var array: [Doc]?
//    var text: String?
//    let networkManager = NetworkManager()
//    
//    init(view: SearchResultView, text: String) {
//        self.view = view
//        self.text = text
//    }
//    
//    func getFilmsFromSearch(with text: String) {
//        networkManager.searchMovie(searchText: text) { result in
//            switch result {
//            case .success(let movie):
//                if self.array == nil {
//                    self.array = [Doc]()
//                }
//                self.array?.append(contentsOf: movie.docs)
//                DispatchQueue.main.async {
//                    self.view?.update()
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
//    
//    func getFilm() {
//        if let text = text {
//            getFilmsFromSearch(with: text)
//        }
//    }
//    
//}
