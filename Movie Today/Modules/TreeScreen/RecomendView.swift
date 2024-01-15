//
//  RecomendView.swift
//  Movie Today
//
//  Created by macbook on 15.01.2024.
//

import UIKit
import SDWebImage

final class RecomendView: UIView {
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    private let title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .montserratSemiBold(ofSize: 16)
        label.textColor = .white
        return label
    }()
    private let year: UILabel = {
        let label = UILabel()
        label.font = .montserratMedium(ofSize: 12)
        label.textColor = .customGray
        return label
    }()
    private let minutes: UILabel = {
        let label = UILabel()
        label.font = .montserratMedium(ofSize: 12)
        label.textColor = .customGray
        return label
    }()
    
    private let genre: UILabel = {
        let label = UILabel()
        label.font = .montserratMedium(ofSize: 12)
        label.textColor = .customGray
        return label
    }()
    
    private let pg: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .blueAccent
        label.layer.borderWidth = 0.2
        label.layer.borderColor = UIColor.blueAccent.cgColor
        label.layer.cornerRadius = 2
        return label
    }()
    
    private let calendar: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "calendar")
        image.tintColor = .customGray
        return image
    }()
    
    private let clock: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "clock.fill")
        image.tintColor = .customGray
        return image
    }()
    
    private let film: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "film.fill")
        image.tintColor = .customGray
        return image
    }()
    
    private let raiting: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .customOrange
        label.text = ""
        return label
    }()
    private let star: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "star.fill")
        image.tintColor = .customOrange
        return image
    }()
    
    private let firstStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .leading
        stack.distribution = .equalSpacing
        stack.axis = .horizontal
        stack.spacing = 5
        return stack
    }()
    private let secondStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .leading
        stack.axis = .horizontal
        stack.spacing = 5
        return stack
    }()
    private let thirdStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .leading
        stack.distribution = .equalSpacing
        stack.axis = .horizontal
        stack.spacing = 5
        return stack
    }()
    private let fourStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .leading
        stack.axis = .horizontal
        stack.spacing = 5
        return stack
    }()
    private let fifthStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .leading
        stack.axis = .vertical
        stack.spacing = 15
        return stack
    }()
    
    private let startStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .horizontal
        stack.spacing = 5
        stack.backgroundColor = .background
        stack.alpha = 0.8
        stack.layer.cornerRadius = 5
        return stack
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .lightGray
        button.backgroundColor = .dark
        button.layer.cornerRadius = 10
        return button
    }()
    
    var closeButtonAction: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .recomendBackground
        layer.cornerRadius = 20
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        addSubviews(imageView, fifthStack, closeButton)
        imageView.addSubviews(startStack)
        firstStack.addArrangedSubview(calendar)
        firstStack.addArrangedSubview(year)
        
        secondStack.addArrangedSubview(clock)
        secondStack.addArrangedSubview(minutes)
        secondStack.addArrangedSubview(pg)
        
        thirdStack.addArrangedSubview(film)
        thirdStack.addArrangedSubview(genre)
        
        fourStack.addArrangedSubview(title)
        
        startStack.addArrangedSubview(star)
        startStack.addArrangedSubview(raiting)
        
        fifthStack.addArrangedSubview(fourStack)
        fifthStack.addArrangedSubview(firstStack)
        fifthStack.addArrangedSubview(secondStack)
        fifthStack.addArrangedSubview(thirdStack)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 115),
    
            fifthStack.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            fifthStack.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            fifthStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            fifthStack.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -5),
            
            startStack.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8),
            startStack.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 8),
            startStack.trailingAnchor.constraint(lessThanOrEqualTo: imageView.trailingAnchor, constant: -40),
            
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            closeButton.heightAnchor.constraint(equalToConstant: 32),
            closeButton.widthAnchor.constraint(equalToConstant: 32)
        ])
        
    }
    
    @objc private func closeButtonTapped() {
        closeButtonAction?()
    }
    
    func config(with model: Doc?) {
        if let name = model?.name {
            self.title.text = name
        } else {
            self.title.text = "Not Found"
        }
            if let year = model?.year {
                self.year.text = String(year)
            } else {
                self.year.text = "Not Found"
            }
            
            if let movieLength = model?.movieLength {
                self.minutes.text = "\(movieLength) minutes"
            } else {
                self.minutes.text = "Not Found"
            }
            
            if let genre = model?.genres?.first?.name, let type = model?.type {
                self.genre.text = "\(genre) | \(type)"
            } else {
                self.genre.text = "Not Found"
            }
            
            if let pg = model?.ageRating {
                self.pg.text = "PG - \(pg)"
            }
            if let rait = model?.rating?.kp {
                raiting.text = String(format: "%.1f", rait)
            }
            
            guard  let image = model?.poster?.url else {return}
            imageView.sd_setImage(with: URL(string: image))
       
    }
    
    func clearView() {
        title.text = nil
        year.text = nil
        minutes.text = nil
        genre.text = nil
        pg.text = nil
        raiting.text = nil
        imageView.image = nil
    }
}
