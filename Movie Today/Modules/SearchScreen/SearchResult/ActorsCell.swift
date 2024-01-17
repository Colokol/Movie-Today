//
//  ActorsCell.swift
//  Movie Today
//
//  Created by macbook on 05.01.2024.
//

import UIKit

final class ActorsCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .customGray
        label.font = .montserratSemiBold(ofSize: 12)
        return label
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
        contentView.addSubviews(imageView, label)
        
    }
    
    private func setupConst() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 7),

            imageView.heightAnchor.constraint(equalToConstant: 80),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.heightAnchor.constraint(equalToConstant: 15)
        ])
    }
    
    func config(with actor: PersonModel) {
        if let name = actor.enName {
            label.text = name
        }
        guard let photo = actor.photo else { return }
        guard let url = URL(string: photo) else { return }
        SDWebImageManager.shared.setImageFromUrl(image: imageView, url: url)
        imageView.layer.cornerRadius = 40
    }
}
