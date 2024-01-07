//
//  DetailViewController.swift
//  Movie Today
//
//  Created by Timofey Spodeneyko on 26.12.23.
//

import UIKit
import SwiftUI
import SDWebImage

class DetailViewController: UIViewController {

    var presenter: DetailPresenterProtocol!

    // MARK: - UI Components
    let backButton = UIButton(type: .system)
    let favouriteButton = UIButton(type: .system)
    let movieTitleLabel = UILabel()
//    let headerStackView = UIStackView()
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
    let castTextView = UITextView()

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupUI()
        setupConstraints()
        navigationController?.navigationBar.isHidden = false
        presenter?.configureScreen()

        favoriteButtonTap()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateGradientLayerFrame()
    }
    
    private func setupNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: favouriteButton)
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.configureWithTransparentBackground()
        appearance.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = UIColor.background

        backButton.setImage(UIImage(systemName: "chevron.left.circle.fill"), for: .normal)
        backButton.tintColor = .customGray
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        favouriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        favouriteButton.tintColor = .white
        favouriteButton.addTarget(self, action: #selector(favouriteButtonTapped), for: .touchUpInside)
        
        movieTitleLabel.text = "Spider-Man No Way Home"
        movieTitleLabel.textAlignment = .center
        movieTitleLabel.textColor = .white
        movieTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        movieBackgroundView.contentMode = .scaleAspectFill
        movieBackgroundView.clipsToBounds = true
        movieBackgroundView.image = UIImage(named: "spider-man_poster")
        movieBackgroundView.alpha = 0.1
        
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.background.cgColor]
        gradientLayer.locations = [0, 1.0]
        movieBackgroundView.layer.addSublayer(gradientLayer)

        movieImageView.contentMode = .scaleAspectFill
        movieImageView.clipsToBounds = true
        movieImageView.layer.cornerRadius = 10
        movieImageView.image = UIImage(named: "spider-man_poster")

        let yearLabel = UILabel.createMetadataLabel(text: "2021")
        let yearIcon = UIImageView.createMetadataIcon(systemName: "calendar")
        let durationLabel = UILabel.createMetadataLabel(text: "148 Minutes")
        let durationIcon = UIImageView.createMetadataIcon(systemName: "clock.fill")
        let genreLabel = UILabel.createMetadataLabel(text: "Action")
        let genreIcon = UIImageView.createMetadataIcon(systemName: "film.fill")
        let divider1 = UIView.createDivider()
        let divider2 = UIView.createDivider()
        
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

        ratingStackView.axis = .horizontal
        ratingStackView.spacing = 5
        ratingStackView.alignment = .center
        [ratingStarImageView, ratingLabel].forEach { ratingStackView.addArrangedSubview($0)}

        UIButton.configureButton(trailerButton, title: "Trailer", systemImageName: "play.fill", backgroundColor: .orange, isLargeIcon: true)
        trailerButton.addTarget(self, action: #selector(trailerButtonTapped), for: .touchUpInside)
        
        UIButton.configureButton(shareButton, title: "", systemImageName: "square.and.arrow.up", backgroundColor: .systemBlue, isLargeIcon: true)
        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)

        buttonsStackView.axis = .horizontal
        buttonsStackView.distribution = .equalSpacing
        buttonsStackView.alignment = .center
        buttonsStackView.spacing = 40
        [trailerButton, shareButton].forEach { buttonsStackView.addArrangedSubview($0)}
        
        descriptionTextView.text = "For the first time in the cinematic history of Spider-Man, our friendly neighborhood hero's identity is revealed, bringing his Super Hero responsibilities into conflict with his normal life and putting those he cares about most at risk. For the first time in the cinematic history of Spider-Man, our friendly neighborhood hero's identity is revealed, bringing his Super Hero responsibilities into conflict with his normal life and putting those he cares about most at risk. For the first time in the cinematic history of Spider-Man, our friendly neighborhood hero's identity is revealed, bringing his Super Hero responsibilities into conflict with his normal life and putting those he cares about most at risk."
        descriptionTextView.textColor = .white
        descriptionTextView.backgroundColor = .clear
        descriptionTextView.font = UIFont.systemFont(ofSize: 16)
        descriptionTextView.textAlignment = .justified
        descriptionTextView.isScrollEnabled = false
        descriptionTextView.isEditable = false
        descriptionTextView.isSelectable = true
        descriptionTextView.dataDetectorTypes = .all
        
        castTextView.text = "Tom Holland, Zendaya."
        castTextView.textColor = .white
        castTextView.backgroundColor = .clear
        castTextView.font = UIFont.systemFont(ofSize: 16)
        castTextView.textAlignment = .justified
        castTextView.isScrollEnabled = false
        castTextView.isEditable = false
        castTextView.isSelectable = true
        castTextView.dataDetectorTypes = .all

        [movieBackgroundView, scrollView, contentView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false; view.addSubview($0)}
        scrollView.addSubview(contentView)
        
        [movieImageView, metadataStackView, ratingStackView, buttonsStackView, descriptionTextView, castTextView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false; contentView.addSubview($0)}
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([

            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: LayoutConstants.topMargin),
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
            movieImageView.widthAnchor.constraint(equalToConstant: LayoutConstants.movieImageWidth),
            movieImageView.heightAnchor.constraint(equalTo: movieImageView.widthAnchor, multiplier: LayoutConstants.movieImageHeightMultiplier),
            
            movieBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            movieBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieBackgroundView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: LayoutConstants.movieBackgroundViewBottomOffset),
            
            metadataStackView.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: LayoutConstants.topMargin),
            metadataStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.metadataStackViewLeadingMargin),
            metadataStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LayoutConstants.metadataStackViewTrailingMargin),
            metadataStackView.heightAnchor.constraint(equalToConstant: LayoutConstants.metadataStackViewHeight),
            
            ratingStackView.topAnchor.constraint(equalTo: metadataStackView.bottomAnchor, constant: LayoutConstants.topMargin),
            ratingStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            ratingStackView.heightAnchor.constraint(equalToConstant: LayoutConstants.ratingStackViewHeight),
            
            trailerButton.heightAnchor.constraint(equalToConstant: LayoutConstants.buttonHeight),
            trailerButton.widthAnchor.constraint(equalToConstant: LayoutConstants.buttonWidth),
            
            shareButton.heightAnchor.constraint(equalToConstant: LayoutConstants.buttonHeight),
            shareButton.widthAnchor.constraint(equalToConstant: LayoutConstants.buttonHeight),

            buttonsStackView.topAnchor.constraint(equalTo: ratingStackView.bottomAnchor, constant: LayoutConstants.topMargin),
            buttonsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.buttonsLeadingMargin),
            buttonsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LayoutConstants.buttonsTrailingMargin),
            buttonsStackView.heightAnchor.constraint(equalToConstant: LayoutConstants.buttonHeight),
            
            descriptionTextView.topAnchor.constraint(equalTo: buttonsStackView.bottomAnchor, constant: LayoutConstants.topMargin),
            descriptionTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.leadingMargin),
            descriptionTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LayoutConstants.trailingMargin),
            
            castTextView.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: LayoutConstants.topMargin),
            castTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.leadingMargin),
            castTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LayoutConstants.trailingMargin),
            castTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: LayoutConstants.contentPadding),
        ])
    }

    private func updateGradientLayerFrame() {
        gradientLayer.frame = movieBackgroundView.bounds
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
    }
    
    // MARK: - Actions
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func favouriteButtonTapped() {
        presenter.saveToFavorit()
    }

    @objc func trailerButtonTapped() {
        if let model = presenter?.movie,
           let id = presenter?.id {
            let vc = Builder.createTrailerVC(model: model, id: id)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func shareButtonTapped() {
        // Tapped button logic
    }
}

extension DetailViewController: DetailScreenViewProtocol {

    func favoriteButtonTap() {
        if presenter.favoriteButtonState {
            favouriteButton.tintColor = .red
        }else {
            favouriteButton.tintColor = .white
        }
    }
    

    
    func update(model: Doc) {
        title = model.name
        descriptionTextView.text = model.description
        let rait =  model.rating?.kp
        ratingLabel.text = String(format: "%.1f", rait ?? "нет информации")
        guard let url = model.poster?.url else {return}
        movieImageView.sd_setImage(with: URL(string: url))
    }
    

}
