//
//  DetailViewController.swift
//  Movie Today
//
//  Created by Timofey Spodeneyko on 26.12.23.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    var presenter: DetailPresenterProtocol!

    // MARK: - UI Components
    private let backButton = UIButton(type: .system)
    private let favouriteButton = UIButton(type: .system)
    private let movieBackgroundView = UIImageView()
    private let gradientLayer = CAGradientLayer()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let movieImageView = UIImageView()
    private let yearLabel = UILabel()
    private let yearIcon = UIImageView()
    private let durationLabel = UILabel()
    private let durationIcon = UIImageView()
    private let genreLabel = UILabel()
    private let genreIcon = UIImageView()
    private let divider1 = UIView()
    private let divider2 = UIView()
    private let metadataStackView = UIStackView()
    private let ratingLabel = UILabel()
    private let ratingStarImageView = UIImageView()
    private let ratingStackView = UIStackView()
    private let trailerButton = UIButton(type: .system)
    private let shareButton = UIButton(type: .system)
    private let buttonsStackView = UIStackView()
    private let descriptionTitle = UILabel()
    private let descriptionTextView = UITextView()
    private let castTitle = UILabel()
    private lazy var actorsCollectionView = UICollectionView()
    
    private let shareView = ShareView()
    private var blur: UIVisualEffectView?

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        setupNavBar()
        setupUI()
        setupConstraints()
        setupShareView()
        presenter.configureScreen()
        presenter.getActors()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateGradientLayerFrame()
    }

    // MARK: - NavBar
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
    
    private func setupShareView() {
        view.addSubviews(shareView)
        shareView.isHidden = true
        shareView.shareButtonAction = {
            UIPasteboard.general.string = self.presenter.movie.videos?.trailers?.first?.url
            self.hideShareView()
        }
        shareView.closeButtonAction = {
            self.hideShareView()
        }
        NSLayoutConstraint.activate([
            shareView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shareView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = UIColor.background

        backButton.setImage(UIImage(systemName: "chevron.left.circle.fill"), for: .normal)
        backButton.tintColor = .customGray
        let backButtonAction = UIAction { [weak self] _ in self?.backButtonTapped() }
        backButton.addAction(backButtonAction, for: .touchUpInside)
        
        favouriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        favouriteButton.tintColor = .white
        let favouriteButtonAction = UIAction { [weak self] _ in self?.favouriteButtonTapped() }
        favouriteButton.addAction(favouriteButtonAction, for: .touchUpInside)

        movieBackgroundView.contentMode = .scaleAspectFill
        movieBackgroundView.clipsToBounds = true
        movieBackgroundView.alpha = 0.1
        
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.background.cgColor]
        gradientLayer.locations = [0, 1.0]
        movieBackgroundView.layer.addSublayer(gradientLayer)

        movieImageView.layer.cornerRadius = 10
        movieImageView.clipsToBounds = true
        movieImageView.contentMode = .scaleAspectFill
        
        yearLabel.textColor = .gray
        yearLabel.font = .montserratRegular(ofSize: 12)
        
        yearIcon.image = UIImage(systemName: "calendar")
        yearIcon.tintColor = .gray
        yearIcon.contentMode = .scaleAspectFit
        
        durationLabel.textColor = .gray
        durationLabel.font = .montserratRegular(ofSize: 12)
        
        durationIcon.image = UIImage(systemName: "clock.fill")
        durationIcon.tintColor = .gray
        durationIcon.contentMode = .scaleAspectFit
        
        genreLabel.textColor = .gray
        genreLabel.font = .montserratRegular(ofSize: 12)
        
        genreIcon.image = UIImage(systemName: "film.fill")
        genreIcon.tintColor = .gray
        
        divider1.backgroundColor = .gray
        divider2.backgroundColor = .gray
        
        metadataStackView.axis = .horizontal
        metadataStackView.spacing = 10
        [yearIcon, yearLabel, divider1, durationIcon, durationLabel, divider2, genreIcon, genreLabel].forEach { metadataStackView.addArrangedSubview($0) }
        
        ratingStarImageView.image = UIImage(systemName: "star.fill")
        ratingStarImageView.tintColor = .orange
        ratingStarImageView.contentMode = .scaleAspectFit

        ratingLabel.textColor = .orange
        ratingLabel.font = .montserratSemiBold(ofSize: 24)

        ratingStackView.axis = .horizontal
        ratingStackView.spacing = 5
        ratingStackView.alignment = .center
        [ratingStarImageView, ratingLabel].forEach { ratingStackView.addArrangedSubview($0)}
        
        var trailerButtonConfiguration = UIButton.Configuration.filled()
        trailerButtonConfiguration.title = "Трейлер"
        trailerButtonConfiguration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = .montserratSemiBold(ofSize: 14)
            return outgoing
        }
        trailerButtonConfiguration.image = UIImage(systemName: "play.fill")
        trailerButtonConfiguration.imagePadding = 5
        trailerButtonConfiguration.imagePlacement = .leading
        trailerButtonConfiguration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(scale: .large)
        trailerButtonConfiguration.baseBackgroundColor = .orange
        trailerButtonConfiguration.cornerStyle = .capsule
        trailerButton.configuration = trailerButtonConfiguration
        let trailerButtonAction = UIAction { [weak self] _ in self?.trailerButtonTapped() }
        trailerButton.addAction(trailerButtonAction, for: .touchUpInside)

        var shareButtonConfiguration = UIButton.Configuration.filled()
        shareButtonConfiguration.image = UIImage(systemName: "square.and.arrow.up")
        shareButtonConfiguration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(scale: .large)
        shareButtonConfiguration.cornerStyle = .capsule
        shareButton.configuration = shareButtonConfiguration
        let shareButtonAction = UIAction { [weak self] _ in self?.shareButtonTapped() }
        shareButton.addAction(shareButtonAction, for: .touchUpInside)

        buttonsStackView.axis = .horizontal
        buttonsStackView.alignment = .center
        buttonsStackView.spacing = 30
        [trailerButton, shareButton].forEach { buttonsStackView.addArrangedSubview($0) }
        
        descriptionTitle.text = "Описание"
        descriptionTitle.textColor = .white
        descriptionTitle.backgroundColor = .clear
        descriptionTitle.font = .montserratSemiBold(ofSize: 18)

        descriptionTextView.textColor = .white
        descriptionTextView.backgroundColor = .clear
        descriptionTextView.font = .montserratRegular(ofSize: 14)
        descriptionTextView.isScrollEnabled = false
        descriptionTextView.isEditable = false
        descriptionTextView.dataDetectorTypes = .all
        
        castTitle.text = "Актерский состав и команда"
        castTitle.textColor = .white
        castTitle.backgroundColor = .clear
        castTitle.font = .montserratSemiBold(ofSize: 18)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        actorsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        actorsCollectionView.dataSource = self
        actorsCollectionView.delegate = self
        actorsCollectionView.backgroundColor = .clear
        actorsCollectionView.showsHorizontalScrollIndicator = false
        actorsCollectionView.register(ActorsCollectionViewCell.self, forCellWithReuseIdentifier: ActorsCollectionViewCell.identifier)

        [movieBackgroundView, scrollView, contentView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false; view.addSubview($0) }
        scrollView.addSubview(contentView)
        
        [movieImageView, metadataStackView, ratingStackView, buttonsStackView, descriptionTitle, descriptionTextView, castTitle, actorsCollectionView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false; contentView.addSubview($0) }
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LayoutConstants.smallTopMargin),
            movieImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            movieImageView.widthAnchor.constraint(equalToConstant: LayoutConstants.movieImageWidth),
            movieImageView.heightAnchor.constraint(equalToConstant: LayoutConstants.movieImageHeight),
            
            movieBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            movieBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieBackgroundView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: LayoutConstants.movieBackgroundViewBottomOffset),

            divider1.heightAnchor.constraint(equalToConstant: LayoutConstants.dividerHeight),
            divider1.widthAnchor.constraint(equalToConstant: LayoutConstants.dividerWidth),
            divider2.heightAnchor.constraint(equalToConstant: LayoutConstants.dividerHeight),
            divider2.widthAnchor.constraint(equalToConstant: LayoutConstants.dividerWidth),
            
            metadataStackView.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: LayoutConstants.topMargin),
            metadataStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            metadataStackView.heightAnchor.constraint(equalToConstant: LayoutConstants.metadataStackViewHeight),
            
            ratingStackView.topAnchor.constraint(equalTo: metadataStackView.bottomAnchor, constant: LayoutConstants.topMargin),
            ratingStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            ratingStackView.heightAnchor.constraint(equalToConstant: LayoutConstants.ratingStackViewHeight),
            
            trailerButton.heightAnchor.constraint(equalToConstant: LayoutConstants.buttonHeight),
            trailerButton.widthAnchor.constraint(equalToConstant: LayoutConstants.trailerButtonWidth),
            
            shareButton.heightAnchor.constraint(equalToConstant: LayoutConstants.buttonHeight),
            shareButton.widthAnchor.constraint(equalToConstant: LayoutConstants.buttonHeight),

            buttonsStackView.topAnchor.constraint(equalTo: ratingStackView.bottomAnchor, constant: LayoutConstants.topMargin),
            buttonsStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            buttonsStackView.heightAnchor.constraint(equalToConstant: LayoutConstants.buttonHeight),
            
            descriptionTitle.topAnchor.constraint(equalTo: buttonsStackView.bottomAnchor, constant: LayoutConstants.topMargin),
            descriptionTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.descriptionTitleLeadingMargin),
            descriptionTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LayoutConstants.trailingMargin),
            
            descriptionTextView.topAnchor.constraint(equalTo: descriptionTitle.bottomAnchor, constant: LayoutConstants.smallTopMargin),
            descriptionTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.leadingMargin),
            descriptionTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LayoutConstants.trailingMargin),
            
            castTitle.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: LayoutConstants.topMargin),
            castTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.descriptionTitleLeadingMargin),
            castTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LayoutConstants.trailingMargin),
            
            actorsCollectionView.topAnchor.constraint(equalTo: castTitle.bottomAnchor, constant: LayoutConstants.smallTopMargin),
            actorsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.leadingMargin),
            actorsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LayoutConstants.trailingMargin),
            actorsCollectionView.heightAnchor.constraint(equalToConstant: LayoutConstants.personImageSize),
            actorsCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    // MARK: - Actions
    func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func favouriteButtonTapped() {
        presenter.saveToFavorit()
        if presenter.favoriteButtonState {
            favouriteButton.tintColor = .red
        } else {
            favouriteButton.tintColor = .white
        }
    }

    func trailerButtonTapped() {
        if let model = presenter?.movie {
            let vc = Builder.createTrailerVC(model: model)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func shareButtonTapped() {
        if blur == nil {
            showShareView()
        } else {
            hideShareView()
        }
    }
    
    private func updateGradientLayerFrame() {
        gradientLayer.frame = movieBackgroundView.bounds
        gradientLayer.startPoint = CGPoint(x: LayoutConstants.gradientLayerXStartPoint, y: LayoutConstants.gradientLayerYStartPoint)
        gradientLayer.endPoint = CGPoint(x: LayoutConstants.gradientLayerXEndPoint, y: LayoutConstants.gradientLayerYEndPoint)
    }
    
    private func showShareView() {
        let blurEffect = UIBlurEffect(style: .regular)
        blur = UIVisualEffectView(effect: blurEffect)
        blur?.frame = self.view.bounds
        blur?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(blur!)
        self.view.bringSubviewToFront(shareView)
        shareView.isHidden = false
    }
    
    private func hideShareView() {
        shareView.isHidden = true
        blur?.isHidden = true
        blur = nil
    }
}

// MARK: - Extensions
extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ actorsCollectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.filmPersons?.count ?? 0
    }
    
    func collectionView(_ actorsCollectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = actorsCollectionView.dequeueReusableCell(withReuseIdentifier: ActorsCollectionViewCell.identifier, for: indexPath) as? ActorsCollectionViewCell else { return UICollectionViewCell() }
        if let actor = presenter.filmPersons?[indexPath.row] {
            cell.config(with: actor)
        }
        return cell
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: LayoutConstants.actorsCollectionViewCellWidth, height: LayoutConstants.personImageSize)
    }
}

extension DetailViewController: DetailScreenViewProtocol {
    func update(model: Doc) {
        title = model.name
        let year = model.year
        yearLabel.text = String(format: "%i", year ?? "нет информации")
        let duration = String(format: "%i", model.movieLength ?? "нет информации")
        durationLabel.text = "\(duration) минут"
        if let genre = model.genres?.first {
            genreLabel.text = genre.name
        }
        descriptionTextView.text = model.description
        let rait = model.rating?.kp
        ratingLabel.text = String(format: "%.1f", rait ?? "нет информации")
        guard let url = model.poster?.url else {return}
        movieBackgroundView.sd_setImage(with: URL(string: url))
        movieImageView.sd_setImage(with: URL(string: url))
    }

    func updateActors() {
        actorsCollectionView.reloadData()
    }
}
