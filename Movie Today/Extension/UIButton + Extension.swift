//
//  UIButton + Extension.swift
//  Movie Today
//
//  Created by Timofey Spodeneyko on 28.12.2023.
//

import UIKit

extension UIButton {
    static func configureButton(_ button: UIButton, title: String, systemImageName: String, backgroundColor: UIColor, isLargeIcon: Bool = false) {
        var config = UIButton.Configuration.filled()
        config.title = title
        config.baseForegroundColor = .white
        config.baseBackgroundColor = backgroundColor
        config.imagePlacement = .leading
        config.cornerStyle = .capsule
        config.imagePadding = 10
        
        if isLargeIcon {
            let largeConfig = UIImage.SymbolConfiguration(pointSize: 22, weight: .medium, scale: .large)
            config.image = UIImage(systemName: systemImageName, withConfiguration: largeConfig)
        } else {
            config.image = UIImage(systemName: systemImageName)
        }
        button.configuration = config
    }
}
