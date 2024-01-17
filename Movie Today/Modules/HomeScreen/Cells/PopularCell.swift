//
//  PopularCell.swift
//  Movie Today
//
//  Created by macbook on 27.12.2023.
//

import UIKit

final class PopularCell: UICollectionViewCell {
    static let identifier = "Popular"
    private let title: UILabel = {
        let label = UILabel()
        label.font = .montserratSemiBold(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    private let genre: UILabel = {
        let label = UILabel()
        label.font = .montserratMedium(ofSize: 12)
        label.textColor = .customGray
        return label
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 10
        return image
    }()
    
    private let raiting: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .customOrange
        label.text = ""
        return label
    }()
    private let star: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "star.fill")
        image.tintColor = .customOrange
        return image
    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.spacing = 5
        stack.backgroundColor = .background
        stack.alpha = 0.8
        stack.layer.cornerRadius = 5
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupView() {
        contentView.addSubviews(title, genre, imageView)
        imageView.addSubviews(stack)
        stack.addArrangedSubview(star)
        stack.addArrangedSubview(raiting)
        self.layer.cornerRadius = 15
        self.backgroundColor = .cellBackground
        
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -53),
            
            title.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            title.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -8),
            title.heightAnchor.constraint(equalToConstant: 17),
            
            genre.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 4),
            genre.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            genre.trailingAnchor.constraint(lessThanOrEqualTo: title.trailingAnchor),
            genre.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            stack.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8),
            stack.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -8),
            stack.leadingAnchor.constraint(greaterThanOrEqualTo: imageView.leadingAnchor, constant: 70)
        ])
    }
    
    func config(with model: Doc) {
        title.text = model.name
        genre.text = model.genres?.first?.name
        
        let rait =  model.rating?.kp
        raiting.text = String(format: "%.1f", rait ?? "нет информации")

        guard let image = model.poster?.url else { return }
        guard let url = URL(string: image) else { return }
        SDWebImageManager.shared.setImageFromUrl(image: imageView, url: url)
    }
    
    func configRecent(with model: RecentMovie) {
        title.text = model.name
        genre.text = model.genre
        raiting.text = String(format: "%.1f", model.raiting)
        if let imageData = model.image {
            imageView.image = UIImage(data: imageData)
        } else {
            imageView.image = UIImage(named: "film")
        }
    }
}
