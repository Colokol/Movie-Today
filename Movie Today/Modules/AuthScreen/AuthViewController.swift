//
//  AuthViewController.swift
//  Movie Today
//
//  Created by macbook on 10.01.2024.
//

import UIKit

final class AuthViewController: UIViewController {
    
    private var signUp: Bool = true {
        willSet {
            if newValue {
                label.text = "Register"
                name.isHidden = false
                name.text = ""
                password.text = ""
                email.text = ""
                checkButton.setTitle("Already have an account?", for: .normal)
                authButton.setTitle("Register", for: .normal)
            } else {
                label.text = "Login"
                name.isHidden = true
                name.text = ""
                password.text = ""
                email.text = ""
                authButton.setTitle("Login", for: .normal)
                checkButton.setTitle("Haven't an account yet?", for: .normal)
            }
        }
    }
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Register"
        label.font = .montserratSemiBold(ofSize: 30)
        label.textColor = .white
        return label
    }()
    
    private let isRegisterLabel: UILabel = {
        let label = UILabel()
        label.font = .montserratRegular(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    private let name: UITextField = {
        let textField = UITextField()
        let placeholder = "Enter your name"
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        textField.font = .montserratMedium(ofSize: 14)
        textField.textColor = .black
        textField.textContentType = .name
        textField.autocapitalizationType = .words
        return textField
    }()
    
    private let email: UITextField = {
        let textField = UITextField()
        let placeholder = "Enter your e-mail"
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.font = .montserratMedium(ofSize: 14)
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        textField.textColor = .customGray
        textField.autocapitalizationType = .none

        return textField
    }()
    
    private let password: UITextField = {
        let textField = UITextField()
        let placeholder = "Enter your password"
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.font = .montserratMedium(ofSize: 14)
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        textField.textColor = .customGray
        textField.isSecureTextEntry = true
        textField.returnKeyType = .done
        return textField
    }()
    
    private let checkButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .montserratMedium(ofSize: 14)
        button.setTitle("Already have an account?", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(checkButtonAction(_:)), for: .touchUpInside)
        return button
    }()
    
    private let authButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .montserratMedium(ofSize: 20)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .customDarkGray
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(authButtonAction), for: .touchUpInside)
        return button
    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.spacing = 15
        return stack
    }()
    
    private let firebase = FirebaseManager.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .background
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        view.addSubviews(label, stack)
        stack.addArrangedSubview(name)
        stack.addArrangedSubview(email)
        stack.addArrangedSubview(password)
        stack.addArrangedSubview(isRegisterLabel)
        stack.addArrangedSubview(checkButton)
        stack.addArrangedSubview(authButton)
        stack.setCustomSpacing(20, after: isRegisterLabel)
        password.delegate = self
        name.delegate = self
        password.delegate = self


    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor),
            label.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor),
            label.heightAnchor.constraint(equalToConstant: 40),
            
            stack.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 40),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            name.heightAnchor.constraint(equalToConstant: 42),
            name.widthAnchor.constraint(equalToConstant: 300),
            email.heightAnchor.constraint(equalToConstant: 42),
            email.widthAnchor.constraint(equalToConstant: 300),
            password.heightAnchor.constraint(equalToConstant: 42),
            password.widthAnchor.constraint(equalToConstant: 300),
            checkButton.heightAnchor.constraint(equalToConstant: 16),
            authButton.heightAnchor.constraint(equalToConstant: 40),
            authButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    @objc private func checkButtonAction(_ sender: UIButton) {
        signUp = !signUp
    }
    
    @objc private func authButtonAction() {
        signUpCheck()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension AuthViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        signUpCheck()
        
        return textField.resignFirstResponder()
    }
    
    
    private func signUpCheck() {
        guard let email = email.text, !email.isEmpty,
              let password = password.text, !password.isEmpty else {
            showAlert("Please fill in all fields")
            return
        }
        if signUp {
            guard let name = name.text, !name.isEmpty else {
                showAlert("Please enter your name")
                return
            }
            firebase.registerUser(name: name, email: email, password: password)
        } else {
            firebase.loginUser(email: email, password: password)
        }
    }
    
    
    private func showAlert(_ text: String) {
        let alert = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
