//
//  EditProfileView.swift
//  Movie Today
//
//  Created by Nikita on 26.12.2023.
//

import UIKit

class EditProfileView: UIView {

    //MARK: - User interface elements
    
    private lazy var userImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.backgroundColor = .red
        return image
    }()
    private lazy var editUserImage: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        return button
    }()
    
    //MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Call function's
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methods
    
    private func setupView() {
        
        // Setup view
        backgroundColor = .blue
        addSubviews(userImage, editUserImage)
        userImage.addSubviews()
    }
}

//MARK: - Extension

private extension EditProfileView {
    
    enum Constans {
        static let tenPoints: CGFloat = 10
        static let fiftyPoints: CGFloat = 50
        static let oneHundredPoints: CGFloat = 100
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            // User image
            userImage.topAnchor.constraint(equalTo: self.topAnchor, constant: Constans.oneHundredPoints),
            userImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            userImage.heightAnchor.constraint(equalToConstant: Constans.oneHundredPoints),
            userImage.widthAnchor.constraint(equalToConstant: Constans.oneHundredPoints),
            
            // Edit user image button
            editUserImage.trailingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: Constans.tenPoints),
            editUserImage.bottomAnchor.constraint(equalTo: userImage.bottomAnchor, constant: Constans.tenPoints),
            editUserImage.heightAnchor.constraint(equalToConstant: Constans.fiftyPoints),
            editUserImage.widthAnchor.constraint(equalToConstant: Constans.fiftyPoints),
        ])
    }
}

#Preview() {
    EditProfileViewController()
}
