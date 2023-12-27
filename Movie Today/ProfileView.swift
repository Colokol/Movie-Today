//
//  ProfileView.swift
//  Movie Today
//
//  Created by Nikita on 27.12.2023.
//

import UIKit

class ProfileView: UIView {
    
    //MARK: - User interface element
    
    let userView = UserView()
    let generalView = GeneralAndMore(labelText: "General")
    
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
        self.backgroundColor = .blue
        self.addSubviews(userView, generalView)
        
        // Setup user view
        userView.layer.borderWidth = 1
        userView.layer.borderColor = UIColor.gray.cgColor
        userView.layer.cornerRadius = 15
        
        // Setup general view
        generalView.layer.borderWidth = 1
        generalView.layer.borderColor = UIColor.gray.cgColor
        generalView.layer.cornerRadius = 15
    }
}

private extension ProfileView {
    
    enum Constans {
        static let fivePoints: CGFloat = 5
        static let tenPoints: CGFloat = 10
        static let twentyPoints: CGFloat = 20
        static let sideMargin: CGFloat = 15
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
            
            // User view
            userView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constans.fiftyPoints),
            userView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constans.sideMargin),
            userView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constans.sideMargin),
            userView.heightAnchor.constraint(equalToConstant: Constans.ninetyPoints),
            
            // General view
            generalView.topAnchor.constraint(equalTo: userView.bottomAnchor, constant: Constans.twentyPoints),
            generalView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constans.sideMargin),
            generalView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constans.sideMargin),
            generalView.heightAnchor.constraint(equalToConstant: Constans.twoHundredPoints),
        ])
    }
}

#Preview() {
    ProfileViewController()
}
