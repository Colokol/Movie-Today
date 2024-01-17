//
//  UIImageView + Extension.swift
//  Movie Today
//
//  Created by Timofey Spodeneyko on 28.12.2023.
//

import UIKit

extension UIImageView {
    static func createMetadataIcon(systemName: String, tintColor: UIColor = .gray) -> UIImageView {
        let imageView = UIImageView(image: UIImage(systemName: systemName))
        imageView.tintColor = tintColor
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
}
