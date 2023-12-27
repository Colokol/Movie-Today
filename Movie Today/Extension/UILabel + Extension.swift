//
//  UILabel + Extension.swift
//  Movie Today
//
//  Created by Uladzislau Yatskevich on 24.12.23.
//

import UIKit

extension UILabel {
    convenience init(text: String = "", font: UIFont? = .montserratRegular(ofSize: 14), textColor: UIColor, textAlignment: NSTextAlignment = .left, numberOfLines: Int = 1) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
    }
}
