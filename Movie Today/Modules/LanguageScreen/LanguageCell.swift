//
//  TableViewCell.swift
//  Notification
//
//  Created by Юрий on 29.12.2023.
//

import UIKit

class LanguageCell: UITableViewCell {
    
    override var isSelected: Bool {
        didSet {
            selectedLanguageLabel.isHidden = !isSelected
        }
    }
    
    let languageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    let selectedLanguageLabel: UILabel = {
        let label = UILabel()
        label.text = "✓"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .blueAccent
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    func configure(language: Language) {
        languageLabel.text = language.name
    }
}
