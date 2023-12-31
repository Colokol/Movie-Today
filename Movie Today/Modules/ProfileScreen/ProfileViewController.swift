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
        
        navigationController?.navigationBar.barTintColor = .background

        // Call function's
        setupView()
        setupConstraints()
    }
    
    //MARK: - Private methods
    
    private func setupView() {

        // Setup view
        view.addSubviews(profileView)
        
        // Added target for button
        profileView.userView.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        profileView.generalView.firstButton.addTarget(self, action: #selector(notificationButtonTapped), for: .touchUpInside)
        profileView.generalView.secondButton.addTarget(self, action: #selector(languageButtonTapped), for: .touchUpInside)
        profileView.moreView.firstButton.addTarget(self, action: #selector(policiesButtonTapped), for: .touchUpInside)
        profileView.moreView.secondButton.addTarget(self, action: #selector(aboutButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - Objective-C methods
    
    @objc func editButtonTapped() {
        let editProfileVC = EditProfileViewController()
        editProfileVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(editProfileVC, animated: true)
    }
    
    @objc func notificationButtonTapped() {
        print("Notification")
    }
    
    @objc func languageButtonTapped() {
        print("Language")
    }
    
    @objc func policiesButtonTapped() {
        let policiesVC = PrivacyViewController()
        policiesVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(policiesVC, animated: true)
    }
    
    @objc func aboutButtonTapped() {
        print("About")
    }
}

//MARK: - Extension

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
