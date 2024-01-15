//
//  ProfileViewController.swift
//  Movie Today
//
//  Created by Nikita on 27.12.2023.
//

import UIKit
import Firebase
import FirebaseStorage

class ProfileViewController: UIViewController {
    
    //MARK: - User interface elements
    
    let profileView = ProfileView()
    let firebase = Firestore.firestore()

    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = .background
        tabBarController?.tabBar.barTintColor = .background

        // Call function's
        setupView()
        setupConstraints()
        fetchUserInfo()
        exitAction()
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
    
    private func exitAction() {
        profileView.exitAction = {
            do {
                try Auth.auth().signOut()
                let vc = AuthViewController()
               // набор всех сцен, которые в данный момент подключены к приложению
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   //забираем первое окно из массива
                    let window = windowScene.windows.first {
                    //делаем его корневым и видимым
                    window.rootViewController = vc
                    window.makeKeyAndVisible()
                    //переход к окну
                    UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil)
                }
                print("Exit-----------------")
            } catch {
                print("Error exit")
            }
        }
    }
    
    //MARK: - Methods
    
    func fetchUserInfo() {
        guard let id = Auth.auth().currentUser?.uid else {
            print("User not logged in")
            return
        }
        let ref = Database.database().reference().child("users").child(id)
        ref.observeSingleEvent(of: .value) { snapshot, _ in
            if let userData = snapshot.value as? [String: AnyObject] {
                let name = userData["name"] as? String ?? "No name"
                let email = userData["email"] as? String ?? "No email"
                let userImage = userData["profileImageUrl"] as? URL
                DispatchQueue.main.async {
                    self.profileView.userView.nameLabel.text = name
                    self.profileView.userView.emailLabel.text = email
                    self.profileView.userView.userImage.sd_setImage(with: userImage)
                }
                self.fetchProfileImageUrl(for: id) { result in
                    switch result {
                    case .success(let success):
                        let url = URL(string: success)
                        DispatchQueue.main.async {
                            self.profileView.userView.userImage.sd_setImage(with: url)
                        }
                    case .failure(let failure):
                        print("Error firebase")
                    }
                }
            }
        }
    }
    
    func fetchProfileImageUrl(for userId: String, completion: @escaping (Result<String, Error>) -> Void) {
        let userImageRef = Database.database().reference().child("users/\(userId)/profileImageUrl")
        userImageRef.observeSingleEvent(of: .value) { snapshot in
            guard let imageUrl = snapshot.value as? String else {
                completion(.failure(NSError(domain: "FirebaseError", code: 0, userInfo: [NSLocalizedDescriptionKey: "URL изображения не найден"])))
                return
            }
            completion(.success(imageUrl))
        }
    }
    
    //MARK: - Objective-C methods
    
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
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: view.topAnchor),
            profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
    }
}
