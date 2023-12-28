//
//  ProfileView.swift
//  Movie Today
//
//  Created by Nikita on 27.12.2023.
//

import UIKit

final class ProfileView: UIView {
    
    //MARK: - User interface element
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.alwaysBounceVertical = true
        scroll.showsVerticalScrollIndicator = false
        scroll.frame = self.bounds
        return scroll
    }()
    let contentView = UIView()
    let userView = UserView()
    let generalView = GeneralAndMore(labelText: "General", firstButtonTitle: "Notification", firstImage: "notif", secondButtonTitle: "Language", secondImage: "lang")
    let moreView = GeneralAndMore(labelText: "More", firstButtonTitle: "Legal and Policies", firstImage: "shield", secondButtonTitle: "About Us", secondImage: "about")
    
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
        self.backgroundColor = .background
        self.addSubviews(scrollView)
        scrollView.addSubviews(contentView)
        contentView.addSubviews(userView, generalView, moreView)
        
        // Setup user view
        userView.layer.borderWidth = 1
        userView.layer.borderColor = UIColor.whiteGray.cgColor
        userView.layer.cornerRadius = 15
        
        // Setup general view
        generalView.layer.borderWidth = 1
        generalView.layer.borderColor = UIColor.whiteGray.cgColor
        generalView.layer.cornerRadius = 15
        
        // Setup more view
        moreView.layer.borderWidth = 1
        moreView.layer.borderColor = UIColor.whiteGray.cgColor
        moreView.layer.cornerRadius = 15
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
            // Scroll view
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            // Content view
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // User view
            userView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: Constans.tenPoints),
            userView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constans.sideMargin),
            userView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constans.sideMargin),
            userView.heightAnchor.constraint(equalToConstant: Constans.ninetyPoints),
            
            // General view
            generalView.topAnchor.constraint(equalTo: userView.bottomAnchor, constant: Constans.twentyPoints),
            generalView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constans.sideMargin),
            generalView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constans.sideMargin),
            generalView.heightAnchor.constraint(equalToConstant: Constans.twoHundredPoints),
            
            // More view
            moreView.topAnchor.constraint(equalTo: generalView.bottomAnchor, constant: Constans.twentyPoints),
            moreView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constans.sideMargin),
            moreView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constans.sideMargin),
            moreView.heightAnchor.constraint(equalToConstant: Constans.twoHundredPoints),
        ])
    }
}
