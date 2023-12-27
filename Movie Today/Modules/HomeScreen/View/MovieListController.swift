//
//  MovieLIstController.swift
//  Movie Today
//
//  Created by macbook on 26.12.2023.
//

import UIKit

final class MovieListController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<MovieListSections, Item>?
    
    var presenter: MovieListPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movie List"
        configureCollectionView()
        configureDataSource()
        presenter.updateController()
        view.backgroundColor = .background
    }

    //MARK: - CollectionViewSetup
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView?.backgroundColor = .clear
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    //MARK: - Layout collectionView
    private func createLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            guard let sectionKind = MovieListSections(rawValue: sectionIndex) else { return nil }
            
            let section: NSCollectionLayoutSection
            switch sectionKind {
            case .categories:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .absolute(50))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
            

                return section
                
            case .popular:
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(370), heightDimension: .absolute(225))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(375), heightDimension: .absolute(225))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                
                section = NSCollectionLayoutSection(group: group)

                return section
            }
        }
    }
    
    //MARK: - Register Cells&Headers Methods
    private func categoriesRegister() -> UICollectionView.CellRegistration<UICollectionViewCell, String> {
        return UICollectionView.CellRegistration<UICollectionViewCell, String> { (cell, indexPath, item) in
            cell.contentView.subviews.forEach { $0.removeFromSuperview() }
            let label = UILabel(frame: cell.bounds)
            label.text = item
            label.textAlignment = .center
            label.textColor = .white
            cell.layer.cornerRadius = 8
            cell.contentView.addSubview(label)
        }
    }
    
    private func MostPopularRegister() -> UICollectionView.CellRegistration<MovieListCell, Doc> {
        return UICollectionView.CellRegistration<MovieListCell, Doc> { (cell, indexPath, item) in
            cell.config(with: item)
        }
    }
    
    //MARK: - DataSource
    private func configureDataSource() {
        let categories = categoriesRegister()
        let mostPopular = MostPopularRegister()
        dataSource = UICollectionViewDiffableDataSource<MovieListSections, Item>(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            switch MovieListSections(rawValue: indexPath.section)! {

            case .categories:
                return collectionView.dequeueConfiguredReusableCell(using: categories, for: indexPath, item: item.categories)
            case .popular:
                return collectionView.dequeueConfiguredReusableCell(using: mostPopular, for: indexPath, item: item.movieModel)
            }
            
        }
        
    }
}

extension MovieListController: MovieViewProtocol {
    func reloadData() {
        collectionView.reloadData()
    }
    
    func update() {
        applySnapshot()
    }
    
    //MARK: - Snapshot
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<MovieListSections, Item>()
        snapshot.appendSections([.categories, .popular])
        let categories = presenter.categories.compactMap { Item(categories: $0)}
        snapshot.appendItems(categories, toSection: .categories)
        presenter.movies?.forEach { model in
            let popular = model.docs.map { Item(movieModel: $0) }
            snapshot.appendItems(popular, toSection: .popular)
        }
        
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    
}

extension MovieListController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            presenter.didSelectItem(at: indexPath)

        }
    }
}
