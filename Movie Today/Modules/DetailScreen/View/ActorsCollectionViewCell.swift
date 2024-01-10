//
//  ActorsCollectionViewCell.swift
//  Movie Today
//
//  Created by Timofey Spodeneyko on 09.01.2024.
//

import UIKit
import SDWebImage

final class ActorsCollectionViewCell: UICollectionViewCell {
    static let identifier = "cell"

    private let personImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 40
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let personName: UILabel = {
        let label = UILabel()
        label.font = .montserratSemiBold(ofSize: 14)
        label.textColor = .white
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 3
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .montserratMedium(ofSize: 10)
        label.textColor = .customGray
        return label
    }()
    
    private let personInfoStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        stack.spacing = 5
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellView()
        setupCellConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCellView() {
        contentView.addSubviews(personImage, personInfoStackView)
        personInfoStackView.addArrangedSubview(personName)
        personInfoStackView.addArrangedSubview(descriptionLabel)
    }
    
    private func setupCellConstraints() {
        NSLayoutConstraint.activate([
            personImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            personImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            personImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            personImage.heightAnchor.constraint(equalToConstant: LayoutConstants.personImageSize),
            personImage.widthAnchor.constraint(equalToConstant: LayoutConstants.personImageSize),
            
            personInfoStackView.leadingAnchor.constraint(equalTo: personImage.trailingAnchor, constant: LayoutConstants.personInfoStackViewLeadingMargin),
            personInfoStackView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: LayoutConstants.personInfoStackViewTrailingMargin),
            personInfoStackView.centerYAnchor.constraint(equalTo: personImage.centerYAnchor)
        ])
    }
    
    func config(with actor: Person) {
        if let photo = actor.photo, let text = actor.name, let description = actor.profession {
            personImage.sd_setImage(with: URL(string: photo))
            personName.text = text
            descriptionLabel.text = description
        }
    }
}
