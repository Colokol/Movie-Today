//
//  CollectionMovieCell.swift
//  Movie Today
//
//  Created by macbook on 26.12.2023.
//

import UIKit
import SDWebImage

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
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 155),
            imageView.widthAnchor.constraint(equalToConstant: 195),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            count.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -16),
            count.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 16),
            count.trailingAnchor.constraint(lessThanOrEqualTo: imageView.trailingAnchor),
            count.heightAnchor.constraint(equalToConstant: 15),
            
            title.bottomAnchor.constraint(equalTo: count.topAnchor, constant: -24),
            title.leadingAnchor.constraint(equalTo: count.leadingAnchor),
            title.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor),
            title.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor)
        ])
    }
    
    func config(with model: CollectionMovieModel) {
        let imageString = model.docs[0].cover.previewUrl
        if let image = imageString {
            imageView.sd_setImage(with: URL(string: image))
        }
        title.text = model.docs[0].name
        count.text = "\(String(describing: model.docs[0].moviesCount)) фильмов"
        
    }
}
