//
//  General&More.swift
//  Movie Today
//
//  Created by Nikita on 27.12.2023.
//

import UIKit

class GeneralAndMore: UIView {
    
    //MARK: - User interface element

    private lazy var viewLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 25)
        return label
    }()
    private lazy var firstImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .white
        image.clipsToBounds = true
        return image
    }()
    let firstButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.titleLabel?.textAlignment = .left
        return button
    }()
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    let secondButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.titleLabel?.textAlignment = .left
        return button
    }()
    private lazy var secondImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        return image
    }()
    
    //MARK: - Initialize
    
    init(labelText: String?, firstButtonTitle: String?, firstImage: String, secondButtonTitle: String?, secondImage: String) {
        super.init(frame: .infinite)
        viewLabel.text = labelText
        firstButton.setTitle(firstButtonTitle, for: .normal)
        self.firstImage.image = UIImage(named: firstImage)
        secondButton.setTitle(secondButtonTitle, for: .normal)
        self.secondImage.image = UIImage(named: secondImage)
        
        // Call function's
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private method
    
    private func setupView() {
        self.addSubviews(viewLabel, firstButton, firstImage, separatorView, secondButton, secondImage)
    }
}

private extension GeneralAndMore {
    
    enum Constans {
        static let twoPoints: CGFloat = 2
        static let tenPoints: CGFloat = 10
        static let twentyPoints: CGFloat = 20
        static let thiryPoints: CGFloat = 30
        static let fiftyFivePoints: CGFloat = 55
        static let ninetyPoints: CGFloat = 90
        static let twoHundredPoints: CGFloat = 200
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // View label
            viewLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Constans.tenPoints),
            viewLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constans.tenPoints),
            viewLabel.heightAnchor.constraint(equalToConstant: Constans.twentyPoints),
            viewLabel.widthAnchor.constraint(equalToConstant: Constans.ninetyPoints),
            
            // First button
            firstButton.topAnchor.constraint(equalTo: viewLabel.bottomAnchor, constant: Constans.twentyPoints),
            firstButton.leadingAnchor.constraint(equalTo: firstImage.leadingAnchor, constant: Constans.tenPoints),
            firstButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constans.tenPoints),
            firstButton.heightAnchor.constraint(equalToConstant: Constans.fiftyFivePoints),
            
            // First image
            firstImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constans.thiryPoints),
            firstImage.widthAnchor.constraint(equalToConstant: Constans.thiryPoints),
            firstImage.heightAnchor.constraint(equalToConstant: Constans.thiryPoints),
            firstImage.centerYAnchor.constraint(equalTo: firstButton.centerYAnchor),
            
            // Separator view
            separatorView.topAnchor.constraint(equalTo: firstButton.bottomAnchor, constant: Constans.tenPoints),
            separatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constans.thiryPoints),
            separatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constans.thiryPoints),
            separatorView.heightAnchor.constraint(equalToConstant: Constans.twoPoints),
            
            // Second button
            secondButton.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: Constans.tenPoints),
            secondButton.leadingAnchor.constraint(equalTo: secondImage.leadingAnchor, constant: Constans.tenPoints),
            secondButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constans.tenPoints),
            secondButton.heightAnchor.constraint(equalToConstant: Constans.fiftyFivePoints),
            
            // Second image
            secondImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constans.thiryPoints),
            secondImage.widthAnchor.constraint(equalToConstant: Constans.thiryPoints),
            secondImage.heightAnchor.constraint(equalToConstant: Constans.thiryPoints),
            secondImage.centerYAnchor.constraint(equalTo: secondButton.centerYAnchor),
        ])
    }
}
#Preview() {
    ProfileViewController()
}
