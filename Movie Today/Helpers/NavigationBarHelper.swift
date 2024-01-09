//
//  NavigationBarHelper.swift
//  Movie Today
//
//  Created by Anna Zaitsava on 9.01.24.
//

import UIKit

protocol BackButtonDelegate: AnyObject {
    func backButtonPressed()
}

class NavigationBarHelper {

    weak var backButtonDelegate: BackButtonDelegate?

    func setupNavigationBar<T: UIViewController>(for viewController: T, title: String) {
        viewController.title = title
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton(for: viewController))

        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)

        if let navigationController = viewController.navigationController {
            navigationController.navigationBar.standardAppearance = appearance
            navigationController.navigationBar.scrollEdgeAppearance = navigationController.navigationBar.standardAppearance
        }
    }

    func backButton<T: UIViewController>(for viewController: T) -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .soft
        button.frame = .init(x: 0, y: 0, width: 24, height: 24)
        button.layer.cornerRadius = button.bounds.size.width / 2

        button.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)

        return button
    }

    @objc private func backButtonPressed() {
        backButtonDelegate?.backButtonPressed()
    }
}

