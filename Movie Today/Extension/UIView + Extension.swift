//
//  UIView + extension.swift
//  Movie Today
//
//  Created by macbook on 27.12.2023.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(view)
        }
    }
    
    static func createDivider() -> UIView {
        let view = UIView()
        view.backgroundColor = .gray
        view.widthAnchor.constraint(equalToConstant: 1).isActive = true
        view.heightAnchor.constraint(equalToConstant: 24).isActive = true
        return view
    }
}
