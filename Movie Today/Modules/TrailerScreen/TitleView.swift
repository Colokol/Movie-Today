//
//  TitleView.swift
//  Movie Today
//
//  Created by macbook on 01.01.2024.
//

import UIKit

final class TitleView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .montserratSemiBold(ofSize: 16)
        label.text = "Film"
        label.textColor = .white
        return label
    }()
    
    private let descriptionLabel: UILabel = {
       let label = UILabel()
        label.font = .montserratMedium(ofSize: 12)
        label.text = "Release Date:"
        label.textColor = .customGray
        return label
    }()
    
    private let yearLabel: UILabel = {
        let label = UILabel()
        label.font = .montserratMedium(ofSize: 12)
        label.text = "01.01.2024"
        label.textColor = .white
        return label
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
         label.font = .montserratMedium(ofSize: 12)
        label.text = "Action"
         label.textColor = .customGray
         return label
     }()
    
    private let lineLabel: UILabel = {
        let label = UILabel()
         label.font = .montserratMedium(ofSize: 12)
        label.text = " | "
         label.textColor = .customGray
         return label
     }()
    
    private let calendar: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "calendar")
        image.tintColor = .customGray
        return image
    }()
    
    private let genre: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "film")
        image.tintColor = .customGray
        return image
    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 5
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        self.addSubviews(titleLabel, stack)
        stack.addArrangedSubview(calendar)
        stack.addArrangedSubview(descriptionLabel)
        stack.addArrangedSubview(yearLabel)
        stack.addArrangedSubview(lineLabel)
        stack.addArrangedSubview(genre)
        stack.addArrangedSubview(genreLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            stack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            stack.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor)
        ])
    }
    
    func config(with model: Doc) {
        titleLabel.text = model.name
        if let genre = model.genres?.first {
            genreLabel.text = genre.name
        }
       // yearLabel.text = String(model.year)
    }
}
