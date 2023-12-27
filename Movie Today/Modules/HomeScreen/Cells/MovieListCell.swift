//
//  MovieListCell.swift
//  Movie Today
//
//  Created by macbook on 27.12.2023.
//

import UIKit
import SDWebImage

final class MovieListCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 15
        return image
    }()
    private let title: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
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
        contentView.addSubviews(imageView, title)
    }
    
    private func setupConst() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: title.topAnchor, constant: -12),
            
            title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            title.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func config(with model: Doc) {
        if let image = model.poster.url {
            imageView.sd_setImage(with: URL(string: image))
        }
        title.text = model.name
    }
}
