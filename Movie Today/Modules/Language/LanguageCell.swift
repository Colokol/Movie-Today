//
//  LanguageCell.swift
//  Movie Today
//
//  Created by Юрий on 11.01.2024.
//

import UIKit

class LanguageCell: UITableViewCell {

    override var isSelected: Bool {
        didSet {
            checkMarkImage.isHidden = !isSelected
        }
    }
    // MARK: - UI Elements
    
    private let languageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.montserratMedium(ofSize: 20)
        return label
    }()
    
    private let checkMarkImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "checkMark"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - View Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    // MARK: - Methods
    
    func configure(language: Language) {
        languageLabel.text = language.name
    }
    
    private func setupCell() {
        self.backgroundColor = .background
        languageLabel.addSubview(checkMarkImage)
        
        [languageLabel, checkMarkImage].forEach { $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            languageLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            languageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            languageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            checkMarkImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            checkMarkImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            checkMarkImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            checkMarkImage.widthAnchor.constraint(equalToConstant: 20),
            checkMarkImage.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
