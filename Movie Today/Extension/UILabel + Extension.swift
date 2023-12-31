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
    
    static func createMetadataLabel(text: String, textColor: UIColor = .gray, fontSize: CGFloat = 16) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = textColor
        label.font = UIFont.systemFont(ofSize: fontSize)
        return label
    }
}

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
