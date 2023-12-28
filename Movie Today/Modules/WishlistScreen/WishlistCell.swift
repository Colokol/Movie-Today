//
//  WishlistCell.swift
//  Movie Today
//
//  Created by Anna Zaitsava on 27.12.23.
//

import UIKit

class WishlistCell: UICollectionViewCell {
    
    static let identifier = "WishlistCell"
    private let bgView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.backgroundColor = .soft
        return view
    }()
    
    private lazy var  movieImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 8
        image.backgroundColor = .red
        return image
    }()
    
    private lazy var genreLabel = UILabel(text: "Action", font: .montserratMedium(ofSize: 12), textColor: .whiteGray, textAlignment: .left, numberOfLines: 1)
    
    private lazy var  nameLabel = UILabel(text: "Spider-Man No Way Home", font: .montserratMedium(ofSize: 14), textColor: .white, textAlignment: .left, numberOfLines: 0)
    
    private lazy var  typeLabel = UILabel(text: "Movie", font: .montserratMedium(ofSize: 12), textColor: .gray, textAlignment: .left, numberOfLines: 1)
    
    private lazy var  ratingLabel = UILabel(text: "4.5", font: .montserratSemiBold(ofSize: 12), textColor: .yellow, textAlignment: .left, numberOfLines: 1)
    
    private lazy var ratingImage = {
       let image =  UIImageView()
        image.image = UIImage(systemName: "star.fill")
        image.tintColor = .yellow
        return image
    }()
    
    private lazy var likeImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Wishlist")
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieImage.image = nil
        genreLabel.text = nil
        nameLabel.text = nil
        typeLabel.text = nil
        ratingLabel.text = nil
        
    }
    
    private func setupUI(){
        addSubviews(bgView)
        bgView.addSubviews(movieImage,genreLabel,nameLabel,typeLabel,ratingImage,ratingLabel,likeImage)
    }
    
    private func setupConstraints() {
        let offset: CGFloat = 12
        let labelOffset: CGFloat = 16
        
        NSLayoutConstraint.activate([
            bgView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bgView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bgView.heightAnchor.constraint(greaterThanOrEqualToConstant: 107),
            
            movieImage.topAnchor.constraint(equalTo: bgView.topAnchor, constant: offset),
            movieImage.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: offset),
            movieImage.heightAnchor.constraint(equalToConstant: 83),
            movieImage.widthAnchor.constraint(equalToConstant: 121),
            
            genreLabel.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: labelOffset),
            genreLabel.topAnchor.constraint(equalTo: movieImage.topAnchor),
            genreLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -offset),
            
            nameLabel.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: labelOffset),
            nameLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -offset),
            nameLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 6),
            
            typeLabel.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: labelOffset),
            typeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 6),
            
            ratingImage.leadingAnchor.constraint(equalTo: typeLabel.trailingAnchor, constant: 8),
            ratingImage.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 6),
            ratingImage.heightAnchor.constraint(equalToConstant: labelOffset),
            ratingImage.widthAnchor.constraint(equalToConstant: labelOffset),
            
            ratingLabel.leadingAnchor.constraint(equalTo: ratingImage.trailingAnchor, constant: 4),
            ratingLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 6),
            
            likeImage.heightAnchor.constraint(equalToConstant: 32),
            likeImage.widthAnchor.constraint(equalToConstant: 32),
            likeImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -offset),
            likeImage.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -offset),
            
            
        ])
    }
    
}
