//
//  EditProfileView.swift
//  Movie Today
//
//  Created by Nikita on 26.12.2023.
//

import UIKit

final class EditProfileView: UIView {

    //MARK: - User interface elements
    
    private let tabBar = TabBarController()
    
    private lazy var userImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    private lazy var editUserImage: UIButton = {
        let button = UIButton()
        button.backgroundColor = .background
        button.tintColor = .cyan
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        return button
    }()
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .montserratSemiBold(ofSize: 20)
        label.text = "Tiffany"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    private lazy var userEmail: UILabel = {
        let label = UILabel()
        label.font = .montserratMedium(ofSize: 14)
        label.text = "Tiffanyjearsey@gmail.com"
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    
    private lazy var nameLabelTextField: UILabel = {
        let label = UILabel()
        label.text = "Full name"
        label.backgroundColor = .background
        label.textAlignment = .center
        label.font = .montserratMedium(ofSize: 15)
        label.textColor = .white
        return label
    }()
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.text = self.nameLabel.text
        textField.font = .montserratMedium(ofSize: 18)
        textField.textColor = .white
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.whiteGray.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: nameLabelTextField.frame.size.height))
        textField.leftViewMode = .always
        return textField
    }()
    private lazy var mistakeLabel: UILabel = {
        let label = UILabel()
        label.text = "* Name already exist"
        label.textColor = .red
        label.font = .montserratMedium(ofSize: 13)
        return label
    }()
    private lazy var emailLabelTextField: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.backgroundColor = .background
        label.textAlignment = .center
        label.font = .montserratMedium(ofSize: 15)
        label.textColor = .white
        return label
    }()
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.text = self.userEmail.text
        textField.font = .montserratMedium(ofSize: 18)
        textField.textColor = .white
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.white.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: nameLabelTextField.frame.size.height))
        textField.leftViewMode = .always
        return textField
    }()
    private lazy var saveChangesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save Changes", for: .normal)
        button.backgroundColor = .cyan
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
    
    //MARK: - Methods
    
    func signatureTextFieldDelegate() {
        nameTextField.delegate = self
        emailTextField.delegate = self
    }
    
    //MARK: - Private methods
    
    private func setupView() {
        
        // Setup view
        backgroundColor = .background
        addSubviews(userImage,
                    editUserImage,
                    nameLabel,
                    userEmail,
                    nameTextField,
                    nameLabelTextField,
                    mistakeLabel,
                    emailTextField,
                    emailLabelTextField,
                    saveChangesButton
        )
        
        // Setup user image
        userImage.image = UIImage(named: "tiff")
        userImage.layer.cornerRadius = 50
        
        // Setup button's
        editUserImage.layer.cornerRadius = 15
        saveChangesButton.layer.cornerRadius = 25
        
        // Setup text field's
        nameTextField.layer.cornerRadius = 20
        emailTextField.layer.cornerRadius = 20
    }
}

//MARK: - Extension

private extension EditProfileView {
    
    enum Constans {
        static let fivePoints: CGFloat = 5
        static let tenPoints: CGFloat = 10
        static let twentyPoints: CGFloat = 20
        static let sideMargin: CGFloat = 24
        static let thiryPoints: CGFloat = 30
        static let fiftyPoints: CGFloat = 50
        static let fiftyFivePoints: CGFloat = 55
        static let seventyPoints: CGFloat = 70
        static let ninetyPoints: CGFloat = 90
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
            editUserImage.heightAnchor.constraint(equalToConstant: Constans.thiryPoints),
            editUserImage.widthAnchor.constraint(equalToConstant: Constans.thiryPoints),
            
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
            nameTextField.topAnchor.constraint(equalTo: userEmail.bottomAnchor, constant: Constans.seventyPoints),
            nameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constans.sideMargin),
            nameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constans.sideMargin),
            nameTextField.heightAnchor.constraint(equalToConstant: Constans.fiftyPoints),
    
            // Name text field label
            nameLabelTextField.bottomAnchor.constraint(equalTo: nameTextField.topAnchor, constant: Constans.tenPoints),
            nameLabelTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor, constant: Constans.twentyPoints),
            nameLabelTextField.heightAnchor.constraint(equalToConstant: Constans.twentyPoints),
            nameLabelTextField.widthAnchor.constraint(equalToConstant: Constans.ninetyPoints),
            
            // Mistake label
            mistakeLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: Constans.fivePoints),
            mistakeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constans.sideMargin),
            mistakeLabel.heightAnchor.constraint(equalToConstant: Constans.twentyPoints),
            mistakeLabel.widthAnchor.constraint(equalToConstant: Constans.twoHundredPoints),
            
            // Email text field
            emailTextField.topAnchor.constraint(equalTo: mistakeLabel.bottomAnchor, constant: Constans.twentyPoints),
            emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constans.sideMargin),
            emailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constans.sideMargin),
            emailTextField.heightAnchor.constraint(equalToConstant: Constans.fiftyPoints),
            
            // Email text field
            emailLabelTextField.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: Constans.tenPoints),
            emailLabelTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor, constant: Constans.twentyPoints),
            emailLabelTextField.heightAnchor.constraint(equalToConstant: Constans.twentyPoints),
            emailLabelTextField.widthAnchor.constraint(equalToConstant: Constans.fiftyPoints),
            
            saveChangesButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -Constans.seventyPoints),
            saveChangesButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constans.sideMargin),
            saveChangesButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constans.sideMargin),
            saveChangesButton.heightAnchor.constraint(equalToConstant: Constans.fiftyFivePoints),
        ])
    }
}

extension EditProfileView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
