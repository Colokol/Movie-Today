//
//  TabBarController.swift
//  Movie Today
//
//  Created by Uladzislau Yatskevich on 24.12.23.
//

import UIKit

final class TabBarController: UITabBarController {

        // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewControllers()
        configureTabBarAppearance()
    }

    private func configureTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 31/255, green: 29/255, blue: 43/255, alpha: 1.0)
        appearance.stackedLayoutAppearance.normal.iconColor = .label
    }

    private func setupViewControllers() {

        let vc1 = UINavigationController(rootViewController: Builder.createHomeVC())
        let vc2 = UINavigationController(rootViewController: Builder.createSearchViewController())
        let vc3 = UINavigationController(rootViewController: Builder.createTreeController())
        let vc4 = UINavigationController(rootViewController: Builder.crateProfileController())

        vc1.tabBarItem.image = UIImage(named: "Home")
        vc2.tabBarItem.image = UIImage(named: "Search")
        vc3.tabBarItem.image = UIImage(named: "Tree")
        vc4.tabBarItem.image = UIImage(named: "Profile")

        vc1.tabBarItem.selectedImage = UIImage(named: "HomeActive")
        vc2.tabBarItem.selectedImage = UIImage(named: "SearchActive")
        vc3.tabBarItem.selectedImage = UIImage(named: "TreeActive")
        vc4.tabBarItem.selectedImage = UIImage(named: "ProfileActive")

        vc1.tabBarItem.imageInsets = UIEdgeInsets(top: 30, left: 30, bottom: 10, right: 0)
        vc2.tabBarItem.imageInsets = UIEdgeInsets(top: 30, left: 0, bottom: 10, right: 0)
        vc3.tabBarItem.imageInsets = UIEdgeInsets(top: 30, left: 0, bottom: 10, right: 0)
        vc4.tabBarItem.imageInsets = UIEdgeInsets(top: 30, left: 0, bottom: 10, right: 30)

        tabBar.tintColor = .black
        setViewControllers([vc1,vc2,vc3,vc4], animated: true)
    }

}

