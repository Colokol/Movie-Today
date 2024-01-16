//
//  ProfilePresenter.swift
//  Movie Today
//
//  Created by Nikita on 16.01.2024.
//

import Foundation

protocol ProfileScreenViewPresenter: AnyObject {
    func updateViewData(name: String?, email: String?, image: URL?)
}

protocol ProfilePresenterProtocol: AnyObject {
    
    func exitActionTapped()
    func fetchUserInfo()
    init(view: ProfileScreenViewPresenter)
}

final class ProfilePresenter: ProfilePresenterProtocol {
    
    //MARK: - Properties
    
    weak var view: ProfileScreenViewPresenter?
    let firebaseManager = FirebaseManager.shared
    var exitAction: (() -> Void)?
    
    //MARK: - Methods
    
    func exitActionTapped() {
        firebaseManager.exitMethod()
    }
    
    func fetchUserInfo() {
        firebaseManager.fetchUserInfo { name, email, image in
            guard let name, let email, let image else { return }
            DispatchQueue.main.async {
                self.view?.updateViewData(name: name, email: email, image: image)
            }
        }
    }
    
    init(view: ProfileScreenViewPresenter) {
        self.view = view
        fetchUserInfo()
    }
}
