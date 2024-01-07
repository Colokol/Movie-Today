//
//  SceneDelegate.swift
//  Movie Today
//
//  Created by Uladzislau Yatskevich on 23.12.23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    private var storageManager = CoreDataManager.shared


    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        if onboardingCompleted() {
            Builder.configureRootViewController(viewController: TabBarController(), window: window)
        } else {
            Builder.configureRootViewController(viewController: OnboardingViewController(), window: window)
        }
        window?.makeKeyAndVisible()
    }
    
    private func onboardingCompleted() -> Bool {
        UserDefaults.standard.bool(forKey: "onboardingCompleted")
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        storageManager.saveContext()
    }

}

