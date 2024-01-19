//
//  HomeViewController.swift
//  Movie Today
//
//  Created by macbook on 23.12.23.
//

import UIKit

final class HomeViewController: UIViewController {
    
    //MARK: - Property
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Sections, Item>?
    private var searchController = UISearchController()
    private var searchResultController = Builder.createHomeSearchResultVC(model: nil)
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let userButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Image"), for: .normal)
        return button
    }()
    private let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "heart"), for: .normal)
        return button
    }()
    var presenter: HomePresenterProtocol!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        presenter.fetchPhoto { image in
            SDWebImageManager.shared.setImageForButton(with: image, for: self.userButton)
        }
        hideKeyboard()
        setupNavBar()
        setupSearchResult()
        configureCollectionView()
        configureDataSource()
        configureActivityIndicator()
        presenter.getCollectionMovie()
        presenter.getMoviesFromCollection()
        userButton.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.fetchPhoto { image in
            self.userButton.sd_setImage(with: image, for: .normal)
            self.userButton.layer.cornerRadius = 20
            self.userButton.clipsToBounds = true
        }
        
        presenter.fetchName { name in
            DispatchQueue.main.async {
                self.navigationItem.title = "Hello \(name)"
            }
        }
    }
    
    //MARK: - Configure ActivityIndicator
    private func configureActivityIndicator() {
        view.addSubviews(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -120),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        view.layoutIfNeeded()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .label
    }
    //MARK: - SearchBarSetup
    private func setupSearchResult() {
        searchController = UISearchController(searchResultsController: searchResultController)
        searchController.searchResultsUpdater = searchResultController
        searchResultController.delegate = self
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search a title"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.searchTextField.textColor = .white
    }
    
    //MARK: - NavBarSetup
    private func setupNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: userButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: likeButton)
        navigationItem.title = ""
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
        
        likeButton.addTarget(self, action: #selector(wishListTap), for: .touchUpInside)
    }
    
    @objc func wishListTap() {
        let wishListViewController = Builder.createWishListVC()
        navigationController?.pushViewController(wishListViewController, animated: true)
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
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            userButton.widthAnchor.constraint(equalToConstant: 46)
        ])
    }
    //MARK: - Layout collectionView
    private func createLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            guard let sectionKind = Sections(rawValue: sectionIndex) else { return nil }
            
            let section: NSCollectionLayoutSection
            switch sectionKind {
                
            case .compilation:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.78), heightDimension: .fractionalWidth(0.41)), subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 16, leading: 0, bottom: 16, trailing: 0)
                section.orthogonalScrollingBehavior = .groupPagingCentered
                section.interGroupSpacing = 12
                
                section.visibleItemsInvalidationHandler = {
                    (items, offset, environment) in
                    
                    items.forEach { item in
                        guard item.representedElementKind == nil else {
                            return
                        }
                        
                        let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2)
                        let minScale: CGFloat = 0.9
                        let maxScale: CGFloat = 1
                        let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width) * 0.2, minScale)
                        item.transform = CGAffineTransform(scaleX: 1, y: scale)
                    }
                }
                return section
                
            case .categories:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .absolute(50))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = .init(top: 16, leading: 0, bottom: 16, trailing: 16)
                
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(52)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)]
                return section
                
            case .mostPopular:
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(160), heightDimension: .absolute(231))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(160), heightDimension: .absolute(231))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = .init(top: 16, leading: 0, bottom: 0, trailing: 16)
                section.interGroupSpacing = 12
                
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(52)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)]
                
                
                
                return section
            }
        }
    }
    
    //MARK: - Register Cells&Headers Methods
    private func compilationRegister() -> UICollectionView.CellRegistration<CollectionMovieCell, Collection> {
        return UICollectionView.CellRegistration<CollectionMovieCell, Collection> { (cell, indexPath, item) in
            cell.config(with: item)
            
            
        }
    }
    
    private func categoriesRegister() -> UICollectionView.CellRegistration<CategoriesCell, Categories> {
        return UICollectionView.CellRegistration<CategoriesCell, Categories> { (cell, indexPath, item) in
            cell.config(with: item)
        }
    }
    
    private func MostPopularRegister() -> UICollectionView.CellRegistration<PopularCell, Doc> {
        return UICollectionView.CellRegistration<PopularCell, Doc> { (cell, indexPath, item) in
            cell.config(with: item)
        }
    }
    
    private func categoriesHeaderRegister() -> UICollectionView.SupplementaryRegistration<SectionHeader> {
        return UICollectionView.SupplementaryRegistration<SectionHeader>(elementKind: UICollectionView.elementKindSectionHeader) { header, _, indexPath in
            header.titleLabel.text = "Categories"
            header.titleLabel.textColor = .white
            header.titleLabel.font = .montserratSemiBold(ofSize: 16)
            header.button.setTitleColor(.blueAccent, for: .normal)
            header.isUserInteractionEnabled = true
            header.button.tag = indexPath.section
            header.button.addTarget(self, action: #selector(self.seeMoreAction(_:)), for: .touchUpInside)
        }
    }
    
    private func MostPopularHeaderRegister() -> UICollectionView.SupplementaryRegistration<SectionHeader> {
        return UICollectionView.SupplementaryRegistration<SectionHeader>(elementKind: UICollectionView.elementKindSectionHeader) { header, _, indexPath in
            header.titleLabel.text = "Most Popular"
            header.titleLabel.textColor = .white
            header.titleLabel.font = .montserratSemiBold(ofSize: 16)
            header.button.setTitleColor(.blueAccent, for: .normal)
            header.isUserInteractionEnabled = true
            header.button.tag = indexPath.section
            header.button.addTarget(self, action: #selector(self.seeMoreAction(_:)), for: .touchUpInside)
        }
    }
    //MARK: - HideKeyboard
    
    private func hideKeyboard() {
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.singleTap(sender:)))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(singleTapGestureRecognizer)
    }
    
    //MARK: - @OBJC
    @objc func seeMoreAction(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            let vc = Builder.createMovieListVC()
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = Builder.createPopularMovieVC(slug: nil, collectionName: nil)
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
    
    @objc func singleTap(sender: UITapGestureRecognizer) {
        self.searchController.searchBar.resignFirstResponder()
        self.searchController.isActive = false
    }
    
    //MARK: - DataSource
    private func configureDataSource() {
        let compilation = compilationRegister()
        let categories = categoriesRegister()
        let mostPopular = MostPopularRegister()
        let catagoriesHeader = categoriesHeaderRegister()
        let mostPopularHeader = MostPopularHeaderRegister()
        
        dataSource = UICollectionViewDiffableDataSource<Sections, Item>(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            switch Sections(rawValue: indexPath.section)! {
            case .compilation:
                return collectionView.dequeueConfiguredReusableCell(using: compilation, for: indexPath, item: item.collectionMovie)
            case .categories:
                return collectionView.dequeueConfiguredReusableCell(using: categories, for: indexPath, item: item.categories)
            case .mostPopular:
                return collectionView.dequeueConfiguredReusableCell(using: mostPopular, for: indexPath, item: item.movieModel)
            }
            
        }
        dataSource?.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            if kind == UICollectionView.elementKindSectionHeader {
                if let sectionKind = Sections(rawValue: indexPath.section) {
                    switch sectionKind {
                    case .compilation:
                        return nil
                    case .categories:
                        return collectionView.dequeueConfiguredReusableSupplementary(using: catagoriesHeader, for: indexPath)
                    case .mostPopular:
                        return collectionView.dequeueConfiguredReusableSupplementary(using: mostPopularHeader, for: indexPath)
                    }
                }
            }
            return nil
        }
        
    }
}

//MARK: - HomeViewProtocol
extension HomeViewController: HomeScreenViewProtocol {
    func updateSearchResults(_ movies: [Doc]) {
        searchResultController.presenter.results = movies
        searchResultController.presenter.reloadData()
    }
    
    func animate(_ start: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            start ? self.activityIndicator.startAnimating() : self.activityIndicator.stopAnimating()
        }
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    func update() {
        applySnapshot()
    }
    
    //MARK: - Snapshot
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Sections, Item>()
        snapshot.appendSections([.compilation, .categories, .mostPopular])
        
        if let compilations = presenter.collectionMovies?.compactMap({ Item(collectionMovie: $0)}) {
            snapshot.appendItems(compilations, toSection: .compilation)
        }
        let categories = presenter.categories.compactMap { Item(categories: $0)}
        snapshot.appendItems(categories, toSection: .categories)
        if let popular = presenter.movies?.compactMap({ Item(movieModel: $0)}) {
            snapshot.appendItems(popular, toSection: .mostPopular)
        }
        
        dataSource?.apply(snapshot, animatingDifferences: true)
        
    }
}
//MARK: - CollectionView Delegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            presenter.didSelectItem(at: indexPath)
        } else if indexPath.section == 0 {
            guard let collectionName = presenter.collectionMovies?[indexPath.row].slug else { return }
            guard let name = presenter.collectionMovies?[indexPath.row].name else { return }
            let vc = Builder.createPopularMovieVC(slug: collectionName, collectionName: name)
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.section == 2 {
            guard let movies = presenter.movies else {return}
            presenter.saveToCoreData(model: movies[indexPath.row])
            let vc = Builder.createDetailVC(model: movies[indexPath.row])
            navigationController?.hidesBottomBarWhenPushed = false
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
//MARK: - SearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        presenter.getFilms(with: searchText)
    }
    
}

extension HomeViewController: UISearchControllerDelegate {
    func willDismissSearchController(_ searchController: UISearchController) {
        if let searchResultsController = searchController.searchResultsController as? SearchResult {
            searchResultsController.presenter.results?.removeAll()
            searchResultsController.presenter.reloadData()
        }
    }
}
extension HomeViewController: SearchResultDelegate {
    func openDetailWithModel(_ model: Doc) {
        let vc = Builder.createDetailVC(model: model)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
