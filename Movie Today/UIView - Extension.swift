//
//  UIView - Extension.swift
//  Movie Today
//
//  Created by Nikita on 25.12.2023.
//

import UIKit

extension UIView {
    
    func addSubviews(_ view: UIView...) {
        view.forEach { views in
            views.translatesAutoresizingMaskIntoConstraints = false
            addSubview(views)
        }
    }
}
