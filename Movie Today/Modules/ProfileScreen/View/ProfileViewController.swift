//
//  ProfileViewController.swift
//  Movie Today
//
//  Created by Nikita on 27.12.2023.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    //MARK: - Properties
    
    var presenter: ProfilePresenterProtocol!
    
    //MARK: - User interface element
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.alwaysBounceVertical = true
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    private let exitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Exit", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .customGray
        button.layer.cornerRadius = 15
        return button
    }()
    let contentView = UIView()
    let userView = UserView()
    let generalView = GeneralAndMore(labelText: "General", firstButtonTitle: "Notification", firstImage: "notif", secondButtonTitle: "Language", secondImage: "lang")
    let moreView = GeneralAndMore(labelText: "More", firstButtonTitle: "Legal and Policies", firstImage: "legal", secondButtonTitle: "About Us", secondImage: "about")

    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = .background
        tabBarController?.tabBar.barTintColor = .background

        // Call function's
        setupView()
        setupConstraints()
    }
    
    //MARK: - Private methods
    
    private func setupView() {
        // Setup view
        view.backgroundColor = .background
        view.addSubviews(scrollView)
        scrollView.addSubviews(contentView)
        contentView.addSubviews(userView, generalView, moreView, exitButton)
        
        // Setup user view
        userView.layer.borderWidth = 1
        userView.layer.borderColor = UIColor.gray.cgColor
        userView.layer.cornerRadius = 15
        
        // Setup general view
        generalView.layer.borderWidth = 1
        generalView.layer.borderColor = UIColor.gray.cgColor
        generalView.layer.cornerRadius = 15
        
        // Setup more view
        moreView.layer.borderWidth = 1
        moreView.layer.borderColor = UIColor.gray.cgColor
        moreView.layer.cornerRadius = 15
        
        // Added target for button
        userView.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        generalView.firstButton.addTarget(self, action: #selector(notificationButtonTapped), for: .touchUpInside)
        generalView.secondButton.addTarget(self, action: #selector(languageButtonTapped), for: .touchUpInside)
        moreView.firstButton.addTarget(self, action: #selector(policiesButtonTapped), for: .touchUpInside)
        moreView.secondButton.addTarget(self, action: #selector(aboutButtonTapped), for: .touchUpInside)
        exitButton.addTarget(self, action: #selector(exitButtonAction), for: .touchUpInside)
    }

    //MARK: - Objective-C methods
    
    @objc private func exitButtonAction() {
        presenter.exitActionTapped()
    }
    
    @objc func editButtonTapped() {
        let editProfileVC = EditProfileViewController()
        editProfileVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(editProfileVC, animated: true)
    }
    
    @objc func notificationButtonTapped() {
        let notificationVC = NotificationViewController()
        notificationVC.modalPresentationStyle = .fullScreen
        navigationController?.show(notificationVC, sender: self)
    }

    @objc func languageButtonTapped() {
        let languageVC = LanguageTableViewController()
        languageVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(languageVC, animated: true)
    }

    @objc func policiesButtonTapped() {
        let policiesVC = PrivacyViewController()
        policiesVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(policiesVC, animated: true)
    }
    
    @objc func aboutButtonTapped() {
        let aboutUsVC = AboutUsViewController()
        aboutUsVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(aboutUsVC, animated: true)
    }
}

//MARK: - Extension

private extension ProfileViewController {

    enum Constans {
        static let fivePoints: CGFloat = 5
        static let tenPoints: CGFloat = 10
        static let twentyPoints: CGFloat = 20
        static let sideMargin: CGFloat = 15
        static let thiryPoints: CGFloat = 30
        static let fiftyPoints: CGFloat = 50
        static let fiftyFivePoints: CGFloat = 55
        static let seventyPoints: CGFloat = 70
        static let ninetyPoints: CGFloat = 90
        static let oneHundredPoints: CGFloat = 100
        static let twoHundredPoints: CGFloat = 200
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            // Scroll view
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // Content view
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            // User view
            userView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: Constans.tenPoints),
            userView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constans.sideMargin),
            userView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constans.sideMargin),
            userView.heightAnchor.constraint(equalToConstant: Constans.ninetyPoints),
            
            // General view
            generalView.topAnchor.constraint(equalTo: userView.bottomAnchor, constant: Constans.twentyPoints),
            generalView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constans.sideMargin),
            generalView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constans.sideMargin),
            generalView.heightAnchor.constraint(equalToConstant: Constans.twoHundredPoints),
            
            // More view
            moreView.topAnchor.constraint(equalTo: generalView.bottomAnchor, constant: Constans.twentyPoints),
            moreView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constans.sideMargin),
            moreView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constans.sideMargin),
            moreView.heightAnchor.constraint(equalToConstant: Constans.twoHundredPoints),
            
            exitButton.topAnchor.constraint(equalTo: moreView.bottomAnchor, constant: 30),
            exitButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constans.sideMargin),
            exitButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constans.sideMargin),
            exitButton.heightAnchor.constraint(equalToConstant: Constans.fiftyFivePoints)
        ])
    }
}

extension ProfileViewController: ProfileScreenViewPresenter {
   
    func updateViewData(name: String?, email: String?, image: URL?) {
        print("Hello")
        userView.configureView(name: name, email: email, image: image)
    }
}
