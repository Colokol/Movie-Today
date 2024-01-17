//
//  SDWebImageManager.swift
//  Movie Today
//
//  Created by macbook on 16.01.2024.
//

import UIKit
import SDWebImage

final class SDWebImageManager {
    
    static let shared = SDWebImageManager()
    private init() { }
    
    func setImageFromUrl(image: UIImageView, url: URL) {
        image.sd_setImage(with: url)
    }
    
    func setImageForButton(with url: URL, for button: UIButton) {
        button.sd_setImage(with: url, for: .normal)
    }
}
