//
//  Button.swift
//  Movie Today
//
//  Created by macbook on 04.01.2024.
//

import UIKit

final class Button: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(image: UIImage) {
        super.init(frame: .zero)
        self.setImage(image, for: .normal)
    }
    
    private func setupButton() {
        self.alpha = 0.8
    }
    
    
}
