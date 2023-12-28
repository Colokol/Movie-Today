//
//  UILabel + Extension.swift
//  Movie Today
//
//  Created by Uladzislau Yatskevich on 24.12.23.
//

import UIKit

extension UILabel {
    convenience init(text: String?, font: UIFont, textColor: UIColor? = .white) {
        self.init(frame: .infinite)
        self.text = text
        self.font = font
        self.textColor = textColor
    }
}
