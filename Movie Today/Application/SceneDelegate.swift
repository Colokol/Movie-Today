//
//  SceneDelegate.swift
//  Movie Today
//
//  Created by Uladzislau Yatskevich on 23.12.23.
//

import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    private var storageManager = CoreDataManager.shared


    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        determineRootViewController()
        window?.makeKeyAndVisible()
        NotificationCenter.default.addObserver(self, selector: #selector(userDidAuthenticate), name: NSNotification.Name("UserDidAuthenticate"), object: nil)
    }

    @objc private func userDidAuthenticate() {
           setMainInterface()
       }

    private func determineRootViewController() {
        if onboardingCompleted() {
            if Auth.auth().currentUser == nil {
                setAuthInterface()
            } else {
                setMainInterface()
            }
        } else {
            setOnboardingInterface()
        }
    }

    private func setMainInterface() {
        let tabBarController = TabBarController()
        let navigationController = UINavigationController(rootViewController: tabBarController)
        navigationController.navigationBar.isHidden = true
        window?.rootViewController = navigationController
    }

    private func setAuthInterface() {
        let authViewController = AuthViewController()
        window?.rootViewController = authViewController
    }

    private func setOnboardingInterface() {
        let onboardingViewController = Builder.createOnboardingViewController()
        let navigationController = UINavigationController(rootViewController: onboardingViewController)
        navigationController.navigationBar.isHidden = true
        window?.rootViewController = navigationController
    }


    private func onboardingCompleted() -> Bool {
        UserDefaults.standard.bool(forKey: "onboardingCompleted")
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        storageManager.saveContext()
    }

}
