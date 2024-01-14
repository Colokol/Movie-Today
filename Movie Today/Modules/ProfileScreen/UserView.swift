//
//  UserView.swift
//  Movie Today
//
//  Created by Nikita on 27.12.2023.
//

import UIKit

final class UserView: UIView {
    
    //MARK: - User interface element
    
    let userImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 35
        image.clipsToBounds = true
        return image
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = .montserratSemiBold(ofSize: 18)
        return label
    }()
    var emailLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .lightGray
        label.font = .montserratMedium(ofSize: 13)
        return label
    }()
    let editButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "edit"), for: .normal)
        return button
    }()
    
    //MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methods
    
    private func setupView() {
        self.addSubviews(userImage, nameLabel, emailLabel, editButton)
    }
}

extension UserView {
    
    enum Constans {
        static let tenPoints: CGFloat = 10
        static let twentyPoints: CGFloat = 20
        static let thiryPoints: CGFloat = 30
        static let fiftyPoints: CGFloat = 50
        static let seventyPoints: CGFloat = 70
        static let ninetyPoints: CGFloat = 200
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // User image
            userImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constans.tenPoints),
            userImage.heightAnchor.constraint(equalToConstant: Constans.seventyPoints),
            userImage.widthAnchor.constraint(equalToConstant: Constans.seventyPoints),
            userImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            // Name label
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Constans.tenPoints),
            nameLabel.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: Constans.twentyPoints),
            nameLabel.heightAnchor.constraint(equalToConstant: Constans.twentyPoints),
            nameLabel.widthAnchor.constraint(equalToConstant: Constans.ninetyPoints),
            
            // Email label
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Constans.tenPoints),
            emailLabel.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: Constans.twentyPoints),
            emailLabel.heightAnchor.constraint(equalToConstant: Constans.twentyPoints),
            emailLabel.widthAnchor.constraint(equalToConstant: Constans.ninetyPoints),
            
            // Edit button
            editButton.leadingAnchor.constraint(equalTo: emailLabel.trailingAnchor, constant: Constans.tenPoints),
            editButton.heightAnchor.constraint(equalToConstant: Constans.thiryPoints),
            editButton.widthAnchor.constraint(equalToConstant: Constans.thiryPoints),
            editButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
}
