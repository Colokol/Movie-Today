//
//  ViewController.swift
//  Movie Today
//
//  Created by Uladzislau Yatskevich on 23.12.23.
//

import UIKit

final class HomeViewController: UIViewController {
    
    //MARK: - Property
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Sections, Item>?
    private let searchController = UISearchController()
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
        setupNavBar()
        configureSearchBar()
        configureCollectionView()
        configureDataSource()
//        presenter.updateController()
        presenter.getCollectionMovie()
    }
    
    //MARK: - NavBarSetup
    private func setupNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: userButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: likeButton)
        navigationItem.title = "Hello smith!"
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.configureWithTransparentBackground()
        appearance.titlePositionAdjustment = UIOffset(horizontal: -100, vertical: 0)
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    //MARK: - SearchBarSetup
    private func configureSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search a title"
        
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
            guard let sectionKind = Sections(rawValue: sectionIndex) else { return nil }
            
            let section: NSCollectionLayoutSection
            switch sectionKind {
                
            case .compilation:
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(295), heightDimension: .absolute(155))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(300), heightDimension: .estimated(205))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                
                return section
            case .categories:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .absolute(50))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                header.pinToVisibleBounds = false
                header.zIndex = 2
                section.boundarySupplementaryItems = [header]
                return section
                
            case .mostPopular:
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(160), heightDimension: .absolute(230))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(160), heightDimension: .estimated(230))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                header.pinToVisibleBounds = false
                header.zIndex = 2
                section.boundarySupplementaryItems = [header]
                
                
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
    
    private func categoriesRegister() -> UICollectionView.CellRegistration<UICollectionViewCell, String> {
        return UICollectionView.CellRegistration<UICollectionViewCell, String> { (cell, indexPath, item) in
            cell.contentView.subviews.forEach { $0.removeFromSuperview() }
            
            let label = UILabel(frame: cell.bounds)
            label.text = item
            label.textAlignment = .center
            label.textColor = .white
            cell.contentView.addSubview(label)
        }
    }
    
    private func MostPopularRegister() -> UICollectionView.CellRegistration<UICollectionViewCell, String> {
        return UICollectionView.CellRegistration<UICollectionViewCell, String> { (cell, indexPath, item) in
            cell.contentView.subviews.forEach { $0.removeFromSuperview() }
            
            let label = UILabel(frame: cell.bounds)
            label.text = item
            label.textAlignment = .center
            label.textColor = .red
            cell.backgroundColor = .white
            cell.contentView.addSubview(label)
        }
    }
    
    private func categoriesHeaderRegister() -> UICollectionView.SupplementaryRegistration<SectionHeader> {
        return UICollectionView.SupplementaryRegistration<SectionHeader>(elementKind: UICollectionView.elementKindSectionHeader) { header, _, indexPath in
            header.titleLabel.text = "Categories"
            header.titleLabel.textColor = .white
            header.button.setTitleColor(.white, for: .normal)
            header.isUserInteractionEnabled = true
            header.button.tag = indexPath.section
            header.button.addTarget(self, action: #selector(self.seeMoreAction(_:)), for: .touchUpInside)
        }
    }
    
    private func MostPopularHeaderRegister() -> UICollectionView.SupplementaryRegistration<SectionHeader> {
        return UICollectionView.SupplementaryRegistration<SectionHeader>(elementKind: UICollectionView.elementKindSectionHeader) { header, _, indexPath in
            header.titleLabel.text = "Most Popular"
            header.titleLabel.textColor = .white
            header.button.setTitleColor(.white, for: .normal)
            header.isUserInteractionEnabled = true
            header.button.tag = indexPath.section
            header.button.addTarget(self, action: #selector(self.seeMoreAction(_:)), for: .touchUpInside)
        }
    }
    
    @objc func seeMoreAction(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            let vc = Builder.createMovieListVC()
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = Builder.createPopularMovieVC()
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
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
                return nil /*collectionView.dequeueConfiguredReusableCell(using: mostPopular, for: indexPath, item: item)*/
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
                        return nil /*collectionView.dequeueConfiguredReusableSupplementary(using: mostPopularHeader, for: indexPath)*/
                    }
                }
            }
            return nil
        }
        
    }
}

//MARK: - HomeViewProtocol
extension HomeViewController: HomeScreenViewProtocol {
    func reloadData() {
        collectionView.reloadData()
    }
    
    func update() {
        applySnapshot()
    }
    
    //MARK: - Snapshot
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Sections, Item>()
        snapshot.appendSections([.compilation, .categories/*.mostPopular*/])
        
        presenter.collectionMovies?.forEach { collectionMovieModel in
            let compilations = collectionMovieModel.docs.map { Item(collectionMovie: $0) }
            snapshot.appendItems(compilations, toSection: .compilation)
        }
        let categories = presenter.categories.compactMap { Item(categories: $0)}
        snapshot.appendItems(categories, toSection: .categories)
        
            
            dataSource?.apply(snapshot, animatingDifferences: true)
        
//        snapshot.appendSections([.compilation/*, .categories, .mostPopular*/])
//        guard let compialtion = presenter.collectionMovies?.compactMap({ Item(collectionMovie: $0.docs)}) else { return }
//        snapshot.appendItems(compialtion, toSection: .compilation)
////        snapshot.appendItems(presenter.categories, toSection: .categories)
////        snapshot.appendItems(presenter.array2, toSection: .mostPopular)
//        
//        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
