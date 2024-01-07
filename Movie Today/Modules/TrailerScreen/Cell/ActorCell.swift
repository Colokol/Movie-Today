//
//  ActorCell.swift
//  Movie Today
//
//  Created by macbook on 04.01.2024.
//

import UIKit
import SDWebImage

final class ActorCell: UICollectionViewCell {
    static let identifier = "cell"
    private let image: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 20
        return image
    }()
    
    private let name: UILabel = {
        let label = UILabel()
        label.font = .montserratSemiBold(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .montserratMedium(ofSize: 10)
        label.textColor = .customGray
        return label
    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        stack.spacing = 5
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConst()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupView() {
        contentView.addSubviews(image, stack)
        stack.addArrangedSubview(name)
        stack.addArrangedSubview(descriptionLabel)
    }
    
    private func setupConst() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            image.heightAnchor.constraint(equalToConstant: 40),
            image.widthAnchor.constraint(equalToConstant: 40),
            
            stack.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 5),
            stack.centerYAnchor.constraint(equalTo: image.centerYAnchor),
            stack.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -5)
        ])
    }
    
    func config(with actor: Person) {
        if let photo = actor.photo, let text = actor.name, let description = actor.profession {
            image.sd_setImage(with: URL(string: photo))
            name.text = text
            descriptionLabel.text = description
        }
        
    }
}
