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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewConfigure()
        view.backgroundColor = .background
        presenter.checkSlug()
        
    }
    
    private func collectionViewConfigure() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(FilmCell.self, forCellWithReuseIdentifier: FilmCell.identifier)
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
}

extension PopularMovieController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 330, height: 150)
    }
}

extension PopularMovieController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(presenter.array?.count ?? 0)
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

extension PopularMovieController: PopularMovieView {
    func update() {
        collectionView.reloadData()
    }
    
    
}
