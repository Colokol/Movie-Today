//
//  SearchView.swift
//  Movie Today
//
//  Created by Nikita on 29.12.2023.
//

import UIKit

class SearchViewController: UIViewController {

    private var searchController = UISearchController()
    private var collectionView: UICollectionView!
    private var searchResultController = Builder.createSearchResultController(person: nil, movie: nil)
    private var dataSource: UICollectionViewDiffableDataSource<SectionsSearch, Item>?
    var presenter: SearchPresentorProtocol!
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Call function's
        configureActivityIndicator()
        setupNavBar()
        setupSearchResult()
        configureCollectionView()
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
    
    //MARK: - Configure ActivityIndicator
    private func configureActivityIndicator() {
        view.addSubviews(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        view.layoutIfNeeded()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .label
    }
    
    private func setupSearchResult() {
        searchController = UISearchController(searchResultsController: searchResultController)
        searchController.searchResultsUpdater = searchResultController
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Type title, categories, years, etc"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.scopeButtonTitles = ["Фильмы", "Актеры"]
        searchController.searchBar.setScopeBarButtonBackgroundImage(UIImage(named: "back"), for: .normal)
        searchController.searchBar.setScopeBarButtonBackgroundImage(UIImage(named: "selectedBack"), for: .selected)
        searchController.searchBar.setScopeBarButtonTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.blueAccent], for: .selected)
        searchController.searchBar.setScopeBarButtonTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .normal)
        searchController.searchBar.showsScopeBar = false
    }
    private func setupNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = UIColor.background
        tabBarController?.tabBar.standardAppearance = tabBarAppearance
        if #available(iOS 15.0, *) {
            tabBarController?.tabBar.scrollEdgeAppearance = tabBarAppearance
        }
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
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(355), heightDimension: .absolute(175))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPagingCentered
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
                
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
    func animate(_ bool: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            bool ? self.activityIndicator.startAnimating() : self.activityIndicator.stopAnimating()
        }
    }
    
    func updateActors(_ actors: [Person]) {
        print("СерчРезалт обновлен с актерами")
        searchResultController.presenter.actors = actors
        searchResultController.presenter.updateModels()
        searchResultController.presenter.reloadData()
//        searchResultController.presenter.getActorInfo(with: actors[0].id)
    }
    
    func hideError(hide: Bool) {
        searchResultController.presenter.showError(hide)
    }
    
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    func updateData() {
        applySnapshot()
    }
    
    func updateSearchResults(_ movies: [Doc], hideError: Bool) {
        if hideError {
            searchResultController.showError(true)
            searchResultController.presenter.movies = movies
            searchResultController.presenter.updateModels()
            searchResultController.presenter.reloadData()
            print("СерчРезалт обновлен с фильмами")
        } else {
            searchResultController.showError(false)
            searchResultController.presenter.movies = movies
            searchResultController.presenter.updateModels()
            searchResultController.presenter.reloadData()
            print("СерчРезалт обновлен с фильмами")
        }
        
    }

}

extension SearchViewController: UISearchBarDelegate {
 
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        presenter.getFilms(with: searchText)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsScopeBar = true
        searchBar.setNeedsLayout()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsScopeBar = false
        searchBar.setNeedsLayout()
    }
    
//    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
//        switch selectedScope {
//        case 0:
//            guard let searchText = searchBar.text, !searchText.isEmpty else { return }
//            presenter.getFilms(with: searchText)
//        case 1:
//            //MARK: - Добавить поиск актеров и фильмов по актерам
//            presenter.getActors(with: 1)
//        default: break
//
//        }
//    }
}

extension SearchViewController: UISearchControllerDelegate {
    
    func willDismissSearchController(_ searchController: UISearchController) {
        if let searchResultController = searchController.searchResultsController as? SearchResultController {
            searchResultController.presenter.movies?.removeAll()
            searchResultController.presenter.actors?.removeAll()
            searchResultController.showError(true)
            searchResultController.presenter.reloadData()
        }
    }
}

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            presenter.didSelectItem(at: indexPath)
        } else if indexPath.section == 1 {
            guard let model = presenter.movies else { return }
            let vc = Builder.createDetailVC(model: model[indexPath.row])
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
