//
//  EmptyWishlistCell.swift
//  Movie Today
//
//  Created by Anna Zaitsava on 9.01.24.
//

import UIKit

class EmptyWishlistCell: UICollectionViewCell {
    
    static let identifier = "EmptyWishlistCell"
    
    private let mainLabel = UILabel(text: "There is no movie yet!",
                                    font: .montserratSemiBold(ofSize: 16),
                                    textColor: .whiteGray,
                                    textAlignment: .center,
                                    numberOfLines: 1)
    
    private let subLabel = UILabel(text:
                                    """
                                    Find your movie by Type title,
                                    categories, years, etc.
                                    """,
                                   font: .montserratMedium(ofSize: 12),
                                   textColor: .customGray,
                                   textAlignment: .center,
                                   numberOfLines: 0)
    
    private let image = {
        let image =  UIImageView()
        image.image = UIImage(named: "emptyWishlist")
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
    
    private func setupUI(){
        addSubviews(mainLabel, subLabel,image)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            image.centerYAnchor.constraint(equalTo: centerYAnchor),
            image.widthAnchor.constraint(equalToConstant: 76),
            image.heightAnchor.constraint(equalToConstant: 76),
            
            mainLabel.centerXAnchor.constraint(equalTo: image.centerXAnchor),
            mainLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 16),
            
            subLabel.centerXAnchor.constraint(equalTo: mainLabel.centerXAnchor),
            subLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 8),            
        ])
    }
    
}

