//
//  CategoriesCell.swift
//  Movie Today
//
//  Created by macbook on 28.12.2023.
//

import UIKit

final class CategoriesCell: UICollectionViewCell {
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .montserratMedium(ofSize: 12)
        return label
    }()
    
    private let view: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 10
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConst()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubviews(view)
        view.addSubviews(label)
    }
    
    private func setupConst() {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func config(with model: Categories) {
        label.text = model.name
        if model.isSelected {
            view.backgroundColor =  UIColor(red: 0.145, green: 0.157, blue: 0.212, alpha: 1)
            label.textColor = .blueAccent
        } else {
            view.backgroundColor = .clear
            label.textColor = .white
        }
    }
}
