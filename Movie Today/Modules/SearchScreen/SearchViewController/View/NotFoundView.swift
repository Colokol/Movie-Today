//
//  NotFoundView.swift
//  Movie Today
//
//  Created by macbook on 30.12.2023.
//

import UIKit

final class NotFoundView: UIView {
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "loop")
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        return image
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .montserratSemiBold(ofSize: 16)
        label.textColor = .white
        label.text = "we are sorry, we can not find the movie :("
        label.numberOfLines = 0
        return label
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .montserratMedium(ofSize: 12)
        label.textColor = .customGray
        label.text = "Find your movie by Type title, categories, years, etc "
        label.numberOfLines = 0
        return label
    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.spacing = 16
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
        self.addSubviews(stack)
        stack.addArrangedSubview(imageView)
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(descriptionLabel)
    }
    
    private func setupConst() {
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stack.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 165),
            stack.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor),
            stack.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor)
        ])
    }
}
