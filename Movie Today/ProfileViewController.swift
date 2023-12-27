//
//  ProfileViewController.swift
//  Movie Today
//
//  Created by Nikita on 27.12.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    //MARK: - User interface elements
    
    let profileView = ProfileView()

    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Call function's
        setupView()
        setupConstraints()
    }
    
    //MARK: - Private methods
    
    private func setupView() {
        view.addSubviews(profileView)
    }
}

private extension ProfileViewController {
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: view.topAnchor),
            profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
