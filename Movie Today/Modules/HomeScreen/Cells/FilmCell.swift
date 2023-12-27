//
//  FilmCell.swift
//  Movie Today
//
//  Created by macbook on 27.12.2023.
//

import UIKit
import SDWebImage

final class FilmCell: UICollectionViewCell {
    
    static let identifier = "cell"
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    private let title: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    private let year: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemGray5
        return label
    }()
    private let minutes: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemGray5
        return label
    }()
    
    private let genre: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemGray5
        return label
    }()
    
    private let pg: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .blue
        label.layer.borderWidth = 0.2
        label.layer.borderColor = UIColor.blue.cgColor
        label.layer.cornerRadius = 2
        return label
    }()
    
    private let calendar: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "calendar")
        image.tintColor = .gray
        return image
    }()
    
    private let clock: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "clock.fill")
        image.tintColor = .gray
        return image
    }()
    
    private let film: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "film.fill")
        image.tintColor = .gray
        return image
    }()
    
    private let raiting: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .orange
        label.text = ""
        return label
    }()
    private let star: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "star.fill")
        image.tintColor = .orange
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
        stack.distribution = .equalSpacing
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
        stack.distribution = .equalSpacing
        stack.axis = .horizontal
        stack.spacing = 5
        return stack
    }()
    private let fifthStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .leading
        stack.distribution = .equalSpacing
        stack.axis = .vertical
        stack.spacing = 15
        return stack
    }()
    
    private let startStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.spacing = 5
        stack.backgroundColor = .background
        stack.alpha = 0.8
        stack.layer.cornerRadius = 5
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubviews(imageView, fifthStack)
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
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 115),
            
            fifthStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            fifthStack.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            fifthStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            fifthStack.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -5),
            
            startStack.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8),
            startStack.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 8),
            startStack.trailingAnchor.constraint(lessThanOrEqualTo: imageView.trailingAnchor, constant: -40)
        ])
       
    }
    
    func config(with model: Doc) {
        title.text = model.name
        year.text = String(model.year)
        if let min = model.movieLength {
            minutes.text = "\(min) minutes"
        }
        if let genre =  model.genres?.first?.name, let gen2 = model.alternativeName {
            self.genre.text = "\(genre) | \(gen2)"
        }
        if let pg = model.ageRating {
            self.pg.text = "PG - \(pg)"
        }
        
        if let rait =  model.rating?.kp {
            raiting.text = String(format: "%.1f", rait)
        }
        imageView.image = UIImage(named: "films")
    }
}
