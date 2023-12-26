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
        image.backgroundColor = .white
        return image
    }()
    private lazy var editUserImage: UIButton = {
        let button = UIButton()
        button.backgroundColor = .green
        button.tintColor = .black
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        return button
    }()
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "Tiffany"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    private lazy var userEmail: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.text = "Tiffanyjearsey@gmail.com"
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    
    private lazy var nameLabelTextField: UILabel = {
        let label = UILabel()
        label.text = "Full name"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
        return label
    }()
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.text = self.nameLabel.text
        textField.textColor = .white
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: nameLabelTextField.frame.size.height))
        textField.leftViewMode = .always
        return textField
    }()
    private lazy var mistakeLabel: UILabel = {
        let label = UILabel()
        label.text = "* Name already exist"
        label.textColor = .red
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    private lazy var emailLabelTextField: UILabel = {
        let label = UILabel()
        label.text = "Full name"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
        return label
    }()
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.text = self.nameLabel.text
        textField.textColor = .white
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: nameLabelTextField.frame.size.height))
        textField.leftViewMode = .always
        return textField
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
        addSubviews(userImage, editUserImage, nameLabel, userEmail, nameLabelTextField, nameTextField, mistakeLabel)
        
        // Setup user image
        userImage.layer.cornerRadius = 50
        
        // Setup edit user image button
        editUserImage.layer.cornerRadius = 15
        
        // Setup text field's
        nameTextField.layer.cornerRadius = 20
    }
}

//MARK: - Extension

private extension EditProfileView {
    
    enum Constans {
        static let fivePoints: CGFloat = 5
        static let tenPoints: CGFloat = 10
        static let twentyPoints: CGFloat = 20
        static let sideMargin: CGFloat = 24
        static let fiftyPoints: CGFloat = 50
        static let seventyPoints: CGFloat = 70
        static let oneHundredPoints: CGFloat = 100
        static let twoHundredPoints: CGFloat = 200
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            // User image
            userImage.topAnchor.constraint(equalTo: self.topAnchor, constant: Constans.oneHundredPoints),
            userImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            userImage.heightAnchor.constraint(equalToConstant: Constans.oneHundredPoints),
            userImage.widthAnchor.constraint(equalToConstant: Constans.oneHundredPoints),
            
            // Edit user image button
            editUserImage.trailingAnchor.constraint(equalTo: userImage.trailingAnchor),
            editUserImage.bottomAnchor.constraint(equalTo: userImage.bottomAnchor),
            editUserImage.heightAnchor.constraint(equalToConstant: 30),
            editUserImage.widthAnchor.constraint(equalToConstant: 30),
            
            // Name label
            nameLabel.topAnchor.constraint(equalTo: editUserImage.bottomAnchor, constant: Constans.twentyPoints),
            nameLabel.heightAnchor.constraint(equalToConstant: Constans.twentyPoints),
            nameLabel.widthAnchor.constraint(equalToConstant: Constans.seventyPoints),
            nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            // User email
            userEmail.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Constans.tenPoints),
            userEmail.heightAnchor.constraint(equalToConstant: Constans.twentyPoints),
            userEmail.widthAnchor.constraint(equalToConstant: Constans.twoHundredPoints),
            userEmail.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            // Name text field
            nameTextField.topAnchor.constraint(equalTo: userEmail.bottomAnchor, constant: Constans.oneHundredPoints),
            nameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constans.sideMargin),
            nameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constans.sideMargin),
            nameTextField.heightAnchor.constraint(equalToConstant: Constans.fiftyPoints),
    
            // Name text field label
            nameLabelTextField.bottomAnchor.constraint(equalTo: nameTextField.topAnchor, constant: Constans.fivePoints),
            nameLabelTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor, constant: Constans.tenPoints),
            nameLabelTextField.heightAnchor.constraint(equalToConstant: Constans.tenPoints),
            nameLabelTextField.widthAnchor.constraint(equalToConstant: Constans.seventyPoints),
            
            // Mistake label
            mistakeLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: Constans.tenPoints),
            mistakeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constans.sideMargin),
            mistakeLabel.heightAnchor.constraint(equalToConstant: Constans.twentyPoints),
            mistakeLabel.widthAnchor.constraint(equalToConstant: Constans.twoHundredPoints),
            
            // Email text field
            emailTextField.topAnchor.constraint(equalTo: mistakeLabel.bottomAnchor, constant: Constans.tenPoints),
        ])
    }
}

#Preview() {
    EditProfileViewController()
}
