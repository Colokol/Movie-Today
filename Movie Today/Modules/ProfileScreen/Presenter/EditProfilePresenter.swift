//
//  EditProfilePresenter.swift
//  Movie Today
//
//  Created by Nikita on 17.01.2024.
//

import Foundation

protocol EditScreenViewPresenter: AnyObject {
    func updateData(_ name: String?, email: String?, image: URL?)
}

protocol EditProfilePresenterProtocol: AnyObject {
    func fetchUserInfo()
    init(view: EditScreenViewPresenter)
}

final class EditProfilePresenter: EditProfilePresenterProtocol {
    
    //MARK: - Properties
    
    weak var view: EditScreenViewPresenter?
    let firebaseManager = FirebaseManager.shared
    
    //MARK: - Methods
    
    func fetchUserInfo() {
        self.firebaseManager.fetchUserInfo { name, email, image in
            guard let name, let email, let image else { return }
            DispatchQueue.main.async {
                self.view?.updateData(name, email: email, image: image)
            }
        }
    }
    
    init(view: EditScreenViewPresenter) {
        self.view = view
        fetchUserInfo()
    }
}
