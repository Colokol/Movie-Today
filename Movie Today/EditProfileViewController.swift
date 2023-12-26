//
//  EditProfileViewController.swift
//  Movie Today
//
//  Created by Nikita on 26.12.2023.
//

import UIKit

class EditProfileViewController: UIViewController {

    //MARK: - User interface elements
    
    let editProfileView = EditProfileView()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Call function's
        setupView()
        setupConstaints()
    }

    //MARK: - Private methods
    
    private func setupView() {
        view.addSubviews(editProfileView)
    }
}

//MARK: - Extension

private extension EditProfileViewController {
    
    func setupConstaints() {
        NSLayoutConstraint.activate([
            editProfileView.topAnchor.constraint(equalTo: view.topAnchor),
            editProfileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            editProfileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            editProfileView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
