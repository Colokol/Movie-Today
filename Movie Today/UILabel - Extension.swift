//
//  UILabel - Extension.swift
//  Movie Today
//
//  Created by Nikita on 25.12.2023.
//

import UIKit

extension UILabel {
    
    convenience init(text: String? = nil, font: UIFont?, textColor: UIColor?) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = textColor
    }
}
