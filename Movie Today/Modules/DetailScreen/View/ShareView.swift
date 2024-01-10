//
//  ShareView.swift
//  Movie Today
//
//  Created by macbook on 08.01.2024.
//

import UIKit

final class ShareView: UIView {
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Share"
        label.textColor = .white
        label.font = .montserratSemiBold(ofSize: 18)
        return label
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton()
        button.setTitle("Copy Link", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .montserratMedium(ofSize: 14)
        button.backgroundColor = .customDarkGray
        button.layer.cornerRadius = 5
        return button
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .lightGray
        button.backgroundColor = .dark
        button.layer.cornerRadius = 10
        return button
    }()
    
    var shareButtonAction: (() -> Void)?
    var closeButtonAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        addSubviews(label, shareButton, closeButton)
        backgroundColor = .cellBackground
        layer.cornerRadius = 20
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 64),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 125),
            label.heightAnchor.constraint(equalToConstant: 22),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -125),
            
            shareButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 60),
            shareButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            shareButton.widthAnchor.constraint(equalToConstant: 80),
            shareButton.heightAnchor.constraint(equalToConstant: 30),
            shareButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            closeButton.heightAnchor.constraint(equalToConstant: 32),
            closeButton.widthAnchor.constraint(equalToConstant: 32)
            
        ])
    }
    
    @objc private func shareButtonTapped() {
        shareButtonAction?()
    }
    
    @objc private func closeButtonTapped() {
        closeButtonAction?()
    }
}
