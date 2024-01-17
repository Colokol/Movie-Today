//
//  CollectionMovieCell.swift
//  Movie Today
//
//  Created by macbook on 26.12.2023.
//

import UIKit

final class CollectionMovieCell: UICollectionViewCell {
    static let identifier = "MovieCell"
    private let imageView = UIImageView()
    private let title = UILabel()
    private let count = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(imageView)
        imageView.addSubview(title)
        imageView.addSubview(count)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        count.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.contentMode = .scaleAspectFill
        title.textColor = .white
        title.numberOfLines = 0
        title.font = .montserratSemiBold(ofSize: 16)
        count.textColor = .white
        count.font = .montserratMedium(ofSize: 12)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            count.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -16),
            count.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 16),
            count.trailingAnchor.constraint(lessThanOrEqualTo: imageView.trailingAnchor),
            count.heightAnchor.constraint(equalToConstant: 15),

            title.bottomAnchor.constraint(lessThanOrEqualTo: count.topAnchor),
            title.leadingAnchor.constraint(equalTo: count.leadingAnchor),
            title.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -8),
            title.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 30)
        ])
    }
    
    func config(with model: Collection) {
        if let imageString = model.cover?.url {
            guard let url = URL(string: imageString) else { return }
            SDWebImageManager.shared.setImageFromUrl(image: imageView, url: url)

        } else {
            print("картинки нет")
            imageView.image = UIImage(named: "film")
        }
        title.text = model.name
        if let count = model.moviesCount {
            self.count.text = "\(count) фильмов"

        }
        
    }
}
