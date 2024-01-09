//
//  File.swift
//  Movie Today
//
//  Created by Юрий on 25.12.2023.
//

import UIKit

class OnboardingView: UIView {
    
    //MARK: - UI Elements
    
    
    private let onboardingImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let onboardingFirstLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 23, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let onboardingSecondLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    

    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(onboardingImage)
        addSubview(onboardingFirstLabel)
        addSubview(onboardingSecondLabel)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public Methods
    
    func setOnboardingImage(image: UIImage) {
        onboardingImage.image = image
    }
    
    func setFirstLabelText(text: String) {
        onboardingFirstLabel.text = text
    }
    
    func setSecondLabelText(text: String) {
        onboardingSecondLabel.text = text
    }
    
    func setPageLabelTransform(transform: CGAffineTransform) {
        onboardingImage.transform = transform
    }
    
    //MARK: - Methods
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            onboardingImage.topAnchor.constraint(equalTo: topAnchor),
            onboardingImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            onboardingImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            onboardingImage.heightAnchor.constraint(equalToConstant: 400),
            
            onboardingFirstLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            onboardingFirstLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            onboardingFirstLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 110),
            
            onboardingSecondLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            onboardingSecondLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            onboardingSecondLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 180)
        ])
    }
    
}
