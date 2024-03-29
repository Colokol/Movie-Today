//
//  General&More.swift
//  Movie Today
//
//  Created by Nikita on 27.12.2023.
//

import UIKit

final class GeneralAndMore: UIView {
    
    //MARK: - User interface element

    private lazy var viewLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .whiteGray
        label.font = UIFont.montserratSemiBold(ofSize: 18)
        return label
    }()
    private lazy var firstImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        return image
    }()
    let firstButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .montserratMedium(ofSize: 14)
        button.titleLabel?.attributedText = NSMutableAttributedString(string: "", attributes: [NSAttributedString.Key.kern: 0.12])
        button.contentHorizontalAlignment = .left
        return button
    }()
    private lazy var firstArrowImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "arrowBut")
        return image
    }()
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    let secondButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .montserratMedium(ofSize: 14)
        button.titleLabel?.attributedText = NSMutableAttributedString(string: "", attributes: [NSAttributedString.Key.kern: 0.12])
        button.contentHorizontalAlignment = .left
        return button
    }()
    private lazy var secondImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        return image
    }()
    private lazy var secondArrowImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "arrowBut")
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
        self.addSubviews(viewLabel, firstButton, firstImage, firstArrowImage, separatorView, secondButton, secondImage, secondArrowImage)
    }
}

private extension GeneralAndMore {
    
    enum Constans {
        static let twoPoints: CGFloat = 2
        static let tenPoints: CGFloat = 10
        static let twentyPoints: CGFloat = 20
        static let thiryPoints: CGFloat = 30
        static let fiftyFivePoints: CGFloat = 55
        static let sixtyPoints: CGFloat = 60
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
            firstButton.leadingAnchor.constraint(equalTo: firstImage.trailingAnchor, constant: Constans.tenPoints),
            firstButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constans.fiftyFivePoints),
            firstButton.heightAnchor.constraint(equalToConstant: Constans.fiftyFivePoints),
            
            // First image
            firstImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constans.thiryPoints),
            firstImage.widthAnchor.constraint(equalToConstant: Constans.thiryPoints),
            firstImage.heightAnchor.constraint(equalToConstant: Constans.thiryPoints),
            firstImage.centerYAnchor.constraint(equalTo: firstButton.centerYAnchor),
            
            // First arrow image
            firstArrowImage.leadingAnchor.constraint(equalTo: firstButton.trailingAnchor, constant: Constans.tenPoints),
            firstArrowImage.centerYAnchor.constraint(equalTo: firstButton.centerYAnchor),
            firstArrowImage.heightAnchor.constraint(equalToConstant: Constans.thiryPoints),
            firstArrowImage.widthAnchor.constraint(equalToConstant: Constans.thiryPoints),
            
            // Separator view
            separatorView.topAnchor.constraint(equalTo: firstButton.bottomAnchor, constant: Constans.tenPoints),
            separatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constans.thiryPoints),
            separatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constans.fiftyFivePoints),
            separatorView.heightAnchor.constraint(equalToConstant: Constans.twoPoints),
            
            // Second button
            secondButton.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: Constans.tenPoints),
            secondButton.leadingAnchor.constraint(equalTo: firstButton.leadingAnchor),
            secondButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constans.fiftyFivePoints),
            secondButton.heightAnchor.constraint(equalToConstant: Constans.fiftyFivePoints),
            
            // Second image
            secondImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constans.thiryPoints),
            secondImage.widthAnchor.constraint(equalToConstant: Constans.thiryPoints),
            secondImage.heightAnchor.constraint(equalToConstant: Constans.thiryPoints),
            secondImage.centerYAnchor.constraint(equalTo: secondButton.centerYAnchor),
            
            // Second arrow image
            secondArrowImage.leadingAnchor.constraint(equalTo: secondButton.trailingAnchor, constant: Constans.tenPoints),
            secondArrowImage.centerYAnchor.constraint(equalTo: secondButton.centerYAnchor),
            secondArrowImage.heightAnchor.constraint(equalToConstant: Constans.thiryPoints),
            secondArrowImage.widthAnchor.constraint(equalToConstant: Constans.thiryPoints),
        ])
    }
}
