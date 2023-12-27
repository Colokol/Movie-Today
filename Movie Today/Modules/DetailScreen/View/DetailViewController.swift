//
//  DetailViewController.swift
//  Movie Today
//
//  Created by Timofey Spodeneyko on 26.12.23.
//

import UIKit
import SwiftUI

class DetailViewController: UIViewController {
    // MARK: - UI Components
    let backButton = UIButton(type: .system)
    let favouriteButton = UIButton(type: .system)
    let movieTitleLabel = UILabel()
    let headerStackView = UIStackView()
    let movieBackgroundView = UIImageView()
    let gradientLayer = CAGradientLayer()
    let scrollView = UIScrollView()
    let contentView = UIView()
    let movieImageView = UIImageView()
    let metadataStackView = UIStackView()
    let ratingLabel = UILabel()
    let ratingStarImageView = UIImageView()
    let ratingStackView = UIStackView()
    let trailerButton = UIButton(type: .system)
    let shareButton = UIButton(type: .system)
    let buttonsStackView = UIStackView()
    let descriptionTextView = UITextView()

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateGradientLayerFrame()
    }

    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = UIColor.background

        backButton.setImage(UIImage(systemName: "chevron.left.circle.fill"), for: .normal)
        backButton.tintColor = .white
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        favouriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        favouriteButton.tintColor = .white
        favouriteButton.addTarget(self, action: #selector(favouriteButtonTapped), for: .touchUpInside)
        
        movieTitleLabel.text = "Spider-Man No Way Home"
        movieTitleLabel.textAlignment = .center
        movieTitleLabel.textColor = .white
        movieTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        headerStackView.addArrangedSubview(backButton)
        headerStackView.addArrangedSubview(movieTitleLabel)
        headerStackView.addArrangedSubview(favouriteButton)
        headerStackView.axis = .horizontal
        headerStackView.distribution = .equalSpacing
        headerStackView.alignment = .center
        view.addSubview(headerStackView)
        
        movieBackgroundView.contentMode = .scaleAspectFill
        movieBackgroundView.clipsToBounds = true
        movieBackgroundView.image = UIImage(named: "spider-man_poster")
        movieBackgroundView.alpha = 0.1
        view.addSubview(movieBackgroundView)
        
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.background.cgColor]
        gradientLayer.locations = [0, 1.0]
        movieBackgroundView.layer.addSublayer(gradientLayer)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        movieImageView.contentMode = .scaleAspectFill
        movieImageView.clipsToBounds = true
        movieImageView.layer.cornerRadius = 10
        movieImageView.image = UIImage(named: "spider-man_poster")

        let yearLabel = createMetadataLabel(text: "2021")
        let yearIcon = createMetadataIcon(systemName: "calendar")
        let durationLabel = createMetadataLabel(text: "148 Minutes")
        let durationIcon = createMetadataIcon(systemName: "clock.fill")
        let genreLabel = createMetadataLabel(text: "Action")
        let genreIcon = createMetadataIcon(systemName: "film.fill")
        let divider1 = createDivider()
        let divider2 = createDivider()
        
        metadataStackView.axis = .horizontal
        metadataStackView.distribution = .equalSpacing
        metadataStackView.alignment = .center
        [yearIcon, yearLabel, divider1, durationIcon, durationLabel, divider2, genreIcon, genreLabel].forEach { metadataStackView.addArrangedSubview($0) }
        
        ratingStarImageView.image = UIImage(systemName: "star.fill")
        ratingStarImageView.tintColor = .orange
        ratingStarImageView.contentMode = .scaleAspectFit
        
        ratingLabel.text = "4.5"
        ratingLabel.textColor = .orange
        ratingLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        
        ratingStackView.addArrangedSubview(ratingStarImageView)
        ratingStackView.addArrangedSubview(ratingLabel)
        ratingStackView.axis = .horizontal
        ratingStackView.spacing = 5
        ratingStackView.alignment = .center

        configureButton(trailerButton, title: "Trailer", systemImageName: "play.fill", backgroundColor: .orange, isLargeIcon: true)
        trailerButton.addTarget(self, action: #selector(trailerButtonTapped), for: .touchUpInside)
        
        configureButton(shareButton, title: "", systemImageName: "square.and.arrow.up", backgroundColor: .systemBlue, isLargeIcon: true)
        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        
        buttonsStackView.addArrangedSubview(trailerButton)
        buttonsStackView.addArrangedSubview(shareButton)
        buttonsStackView.axis = .horizontal
        buttonsStackView.distribution = .equalSpacing
        buttonsStackView.alignment = .center
        buttonsStackView.spacing = 40
        
        descriptionTextView.text = "For the first time in the cinematic history of Spider-Man, our friendly neighborhood hero's identity is revealed, bringing his Super Hero responsibilities into conflict with his normal life and putting those he cares about most at risk."
        descriptionTextView.textColor = .white
        descriptionTextView.backgroundColor = .clear
        descriptionTextView.font = UIFont.systemFont(ofSize: 14)
        descriptionTextView.isScrollEnabled = true
        descriptionTextView.isEditable = false
        descriptionTextView.isSelectable = true
        descriptionTextView.dataDetectorTypes = .all
        
        [movieImageView, metadataStackView, ratingStackView, buttonsStackView, descriptionTextView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false; contentView.addSubview($0)}
    }
    
    // MARK: - Additional Functions
    private func updateGradientLayerFrame() {
        gradientLayer.frame = movieBackgroundView.bounds
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
    }
    
    private func createMetadataLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }
    
    private func createMetadataIcon(systemName: String) -> UIImageView {
        let imageView = UIImageView(image: UIImage(systemName: systemName))
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    private func createDivider() -> UIView {
        let view = UIView()
        view.backgroundColor = .gray
        view.widthAnchor.constraint(equalToConstant: 1).isActive = true
        view.heightAnchor.constraint(equalToConstant: 24).isActive = true
        return view
    }
    
    private func configureButton(_ button: UIButton, title: String, systemImageName: String, backgroundColor: UIColor, isLargeIcon: Bool = false) {
        var config = UIButton.Configuration.filled()
        config.title = title
        config.baseForegroundColor = .white
        config.baseBackgroundColor = backgroundColor
        config.imagePlacement = .leading
        config.cornerStyle = .capsule
        config.imagePadding = 10

        if isLargeIcon {
            let largeConfig = UIImage.SymbolConfiguration(pointSize: 22, weight: .medium, scale: .large)
            config.image = UIImage(systemName: systemImageName, withConfiguration: largeConfig)
        } else {
            config.image = UIImage(systemName: systemImageName)
        }
        button.configuration = config
    }

    // MARK: - Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            headerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            headerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            headerStackView.heightAnchor.constraint(equalToConstant: 30),

            scrollView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 10),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            movieImageView.widthAnchor.constraint(equalToConstant: 200),
            movieImageView.heightAnchor.constraint(equalTo: movieImageView.widthAnchor, multiplier: 16.0/9.0),
            
            movieBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            movieBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieBackgroundView.bottomAnchor.constraint(equalTo: trailerButton.bottomAnchor, constant: 20),
            
            metadataStackView.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 20),
            metadataStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50),
            metadataStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            metadataStackView.heightAnchor.constraint(equalToConstant: 24),
            
            ratingStackView.topAnchor.constraint(equalTo: metadataStackView.bottomAnchor, constant: 20),
            ratingStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            trailerButton.heightAnchor.constraint(equalToConstant: 50),
            trailerButton.widthAnchor.constraint(equalToConstant: 140),
            
            shareButton.heightAnchor.constraint(equalToConstant: 50),
            shareButton.widthAnchor.constraint(equalToConstant: 50),

            buttonsStackView.topAnchor.constraint(equalTo: ratingStackView.bottomAnchor, constant: 20),
            buttonsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 70),
            buttonsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -70),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 50),
            
            descriptionTextView.topAnchor.constraint(equalTo: buttonsStackView.bottomAnchor, constant: 20),
            descriptionTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            descriptionTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
        ])
    }

    // MARK: - Actions
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func favouriteButtonTapped() {
        // Tapped button logic
    }
    
    @objc func trailerButtonTapped() {
        // Tapped button logic
    }
    
    @objc func shareButtonTapped() {
        // Tapped button logic
    }
}







// MARK: - Preview (will be delete)
struct MovieDetailViewControllerPreview: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            DetailViewController()
        }
    }
}

struct ViewControllerPreview<ViewController: UIViewController>: UIViewControllerRepresentable {
    let viewController: ViewController
    
    init(_ builder: @escaping () -> ViewController) {
        viewController = builder()
    }
    
    func makeUIViewController(context: Context) -> ViewController {
        viewController
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {}
}
