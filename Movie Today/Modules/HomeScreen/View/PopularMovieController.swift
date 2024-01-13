//
//  PopularMovieController.swift
//  Movie Today
//
//  Created by macbook on 26.12.2023.
//

import UIKit

final class PopularMovieController: UIViewController {
    
    private var collectionView: UICollectionView!
    var presenter: PopularMoviePresenterProtocol!
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let errorView = NotFoundView()
    
    
    private let button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .soft
        button.frame = .init(x: 0, y: 0, width: 24, height: 24)
        button.layer.cornerRadius = button.bounds.size.width / 2
        return button
    }()
    //MARK: - Lyfe cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        errorView.isHidden = true
        configureActivityIndicator()
        setupNavBar()
        collectionViewConfigure()
        view.backgroundColor = .background
        presenter.checkSlug()
        
    }
    
    //MARK: - Configure ActivityIndicator
    private func configureActivityIndicator() {
        view.addSubviews(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        view.layoutIfNeeded()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .label
    }
    //MARK: - NavBarSetup
    private func setupNavBar() {
        title = "Popular Movie"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        
        button.addTarget(self, action: #selector(backButton), for: .touchUpInside)
    }
    //MARK: - Configure CollectionView
    private func collectionViewConfigure() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(FilmCell.self, forCellWithReuseIdentifier: FilmCell.identifier)
        view.addSubviews(collectionView, errorView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            errorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    @objc func backButton() {
        navigationController?.popViewController(animated: true)
    }
    
}
//MARK: - DelegateFlowLayout
extension PopularMovieController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 330, height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
//MARK: - DataSource
extension PopularMovieController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.array?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmCell.identifier, for: indexPath) as? FilmCell else { return UICollectionViewCell() }
        if let model = presenter.array?[indexPath.row] {
            cell.config(with: model)
        }
        
        return cell
    }
    
    
}
//MARK: - PopularMovieView
extension PopularMovieController: PopularMovieView {
    func showError(_ hide: Bool) {
        errorView.isHidden = !hide
    }
    
    func animate(_ start: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            start ? self.activityIndicator.startAnimating() : self.activityIndicator.stopAnimating()
        }
    }
    
    func update() {
        collectionView.reloadData()
    }
    
    
}
//MARK: - CollectionViewDelegate
extension PopularMovieController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let model = presenter.array?[indexPath.row] else { return }
        presenter.saveToCoreData(model: model)
        let vc = Builder.createDetailVC(model: model)
        navigationController?.pushViewController(vc, animated: true)
    }
}
