//
//  SearchView.swift
//  Movie Today
//
//  Created by Nikita on 29.12.2023.
//

import UIKit

class SearchViewController: UIViewController, UICollectionViewDelegate {

    private var searchController = UISearchController()
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<SectionsSearch, Item>?
    var presenter: SearchPresentorProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call function's
        configureCollectionView()
        configureSearchController()
        presenter.getUpcomingMovie()
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .background
        collectionView.delegate = self
        configureDataSource()
        view.backgroundColor = .background
        view.addSubviews(collectionView)
        
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureSearchController() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Type title, categories, years, etc"
    }
    
    private func createLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            guard let sectionKind = SectionsSearch(rawValue: sectionIndex) else { return nil }
            let section: NSCollectionLayoutSection
            
            switch sectionKind {
                
            case .categories:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .absolute(50))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                
                return section
                
            case .compilation:
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(355), heightDimension: .absolute(175))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(355), heightDimension: .estimated(175))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPagingCentered
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                header.pinToVisibleBounds = false
                header.zIndex = 2
                section.boundarySupplementaryItems = [header]

                return section
                
            case .mostPopular:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(150), heightDimension: .absolute(231))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                header.pinToVisibleBounds = false
                header.zIndex = 2
                section.boundarySupplementaryItems = [header]
                
                return section
            }
        }
    }
    
    private func registerCellCategories() -> UICollectionView.CellRegistration<CategoriesCell, Categories> {
        return UICollectionView.CellRegistration<CategoriesCell, Categories> { (cell, indexPath, item) in
            cell.config(with: item)
        }
    }
    
    private func registerCellUpcomingMovie() -> UICollectionView.CellRegistration<FilmCell, Doc> {
        return UICollectionView.CellRegistration<FilmCell, Doc> { (cell, indexPath, item) in
            cell.config(with: item)
        }
    }
    
    private func registerCellRecentMoview() -> UICollectionView.CellRegistration<PopularCell, Doc> {
        return UICollectionView.CellRegistration<PopularCell, Doc> { (cell, indexPath, item) in
            cell.config(with: item)
        }
    }
    
    private func upcomingMovieHeaderRegister() -> UICollectionView.SupplementaryRegistration<SectionHeader> {
        return UICollectionView.SupplementaryRegistration<SectionHeader>(elementKind: UICollectionView.elementKindSectionHeader) { header, _, indexPath in
            header.titleLabel.text = "Upcoming Movie"
            header.titleLabel.textColor = .white
            header.titleLabel.font = .montserratSemiBold(ofSize: 16)
            header.button.setTitleColor(.blueAccent, for: .normal)
            header.button.tag = indexPath.section
            header.isUserInteractionEnabled = true
        }
    }
    
    private func recentMoviewHeaderRegister() -> UICollectionView.SupplementaryRegistration<SectionHeader> {
        return UICollectionView.SupplementaryRegistration<SectionHeader>(elementKind: UICollectionView.elementKindSectionHeader) { header, _, indexPath in
            header.titleLabel.text = "Recent movie"
            header.titleLabel.textColor = .white
            header.titleLabel.font = .montserratSemiBold(ofSize: 16)
            header.button.setTitleColor(.blueAccent, for: .normal)
            header.button.tag = indexPath.section
            header.isUserInteractionEnabled = true
        }
    }
    
    private func configureDataSource() {
        let categories = registerCellCategories()
        let upcomingMovie = registerCellUpcomingMovie()
        let recentMovies = registerCellRecentMoview()
        let headerUpcoming = upcomingMovieHeaderRegister()
        let headerRecent = recentMoviewHeaderRegister()
        dataSource = UICollectionViewDiffableDataSource<SectionsSearch, Item>(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            switch SectionsSearch(rawValue: indexPath.section)! {

            case .compilation:
                return collectionView.dequeueConfiguredReusableCell(using: upcomingMovie, for: indexPath, item: item.movieModel)
            case .mostPopular:
                return collectionView.dequeueConfiguredReusableCell(using: recentMovies, for: indexPath, item: item.movieModel) // Забрать из кордаты модель просмотренных фильмов
            case .categories:
                return collectionView.dequeueConfiguredReusableCell(using: categories, for: indexPath, item: item.categories)
            }
        }
        
        dataSource?.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            if kind == UICollectionView.elementKindSectionHeader {
                if let sectionKind = SectionsSearch(rawValue: indexPath.section) {
                    switch sectionKind {
                        
                    case .compilation:
                        return collectionView.dequeueConfiguredReusableSupplementary(using: headerUpcoming, for: indexPath)
                    case .categories:
                        print("Hi")
                    case .mostPopular:
                        return collectionView.dequeueConfiguredReusableSupplementary(using: headerRecent, for: indexPath)
                    }
                }
            }
            return nil
        }
    }
    
    private func applySnapshot() {
        var snapShot = NSDiffableDataSourceSnapshot<SectionsSearch, Item>()
        snapShot.appendSections([.categories, .compilation, .mostPopular])
        
        let categories = presenter.categories.compactMap({ Item(categories: $0) })
            snapShot.appendItems(categories, toSection: .categories)
        
        if let upcomingMovie = presenter.movies?.compactMap({ Item(movieModel: $0) }) {
            snapShot.appendItems(upcomingMovie, toSection: .compilation)
        }
        if let upcomingMovie = presenter.moviesTwo?.compactMap({ Item(movieModel: $0) }) {
            snapShot.appendItems(upcomingMovie, toSection: .mostPopular)
        }
        
        dataSource?.apply(snapShot, animatingDifferences: true)
    }
}

extension SearchViewController: SearchViewProtocol {
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    func updateData() {
        applySnapshot()
    }
}
