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
            selectedLanguageLabel.isHidden = !isSelected
        }
    }
    // MARK: - UI Elements
    
    private let languageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private let selectedLanguageLabel: UILabel = {
        let label = UILabel()
        label.text = "✓"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .blueAccent
        return label
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
        [languageLabel, selectedLanguageLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            languageLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            languageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            languageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            selectedLanguageLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            selectedLanguageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            selectedLanguageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
}
