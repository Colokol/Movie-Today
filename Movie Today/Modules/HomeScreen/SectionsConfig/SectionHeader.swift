//
//  SectionHeader.swift
//  Movie Today
//
//  Created by macbook on 24.12.2023.
//

import UIKit

//MARK: - Header
final class SectionHeader: UICollectionReusableView {
    static let reuseIdentifier = "header"
    let titleLabel = UILabel()
    let button = UIButton()
       
       override init(frame: CGRect) {
           super.init(frame: frame)
           configure()
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
    
    private func configure() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        addSubview(button)
        
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            button.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        button.setTitle(button.isSelected ? "Hide" : "See All", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        button.isUserInteractionEnabled = true
        titleLabel.font = .montserratSemiBold(ofSize: 20)
    }
}
