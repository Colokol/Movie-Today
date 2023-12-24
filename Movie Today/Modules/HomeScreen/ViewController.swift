//
//  ViewController.swift
//  Movie Today
//
//  Created by Uladzislau Yatskevich on 23.12.23.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Sections, String>?
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        setupNavBar()
        configureSearchBar()
        configureCollectionView()
        configureDataSource()
        applySnapshot()
    }
    
    //MARK: - NavBarSetup
    private func setupNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: userButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: likeButton)
        title = "Hello smith!"
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
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(295), heightDimension: .absolute(200))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(300), heightDimension: .estimated(200))
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
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(230))
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
    
    private func compilationRegister() -> UICollectionView.CellRegistration<UICollectionViewCell, String> {
        return UICollectionView.CellRegistration<UICollectionViewCell, String> { (cell, indexPath, item) in
            // Удаление старых вью из contentView перед добавлением новых
            cell.contentView.subviews.forEach { $0.removeFromSuperview() }
            
            let label = UILabel(frame: cell.bounds)
            label.text = item
            label.textAlignment = .center
            label.textColor = .red
            cell.backgroundColor = .white
            cell.contentView.addSubview(label)
        }
    }
    
    private func categoriesRegister() -> UICollectionView.CellRegistration<UICollectionViewCell, String> {
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
        }
    }
    
    private func MostPopularHeaderRegister() -> UICollectionView.SupplementaryRegistration<SectionHeader> {
        return UICollectionView.SupplementaryRegistration<SectionHeader>(elementKind: UICollectionView.elementKindSectionHeader) { header, _, indexPath in
            header.titleLabel.text = "Most Popular"
            header.titleLabel.textColor = .white
            header.button.setTitleColor(.white, for: .normal)
            header.isUserInteractionEnabled = true
            header.button.tag = indexPath.section
        }
    }
    
    //MARK: - DataSource
    
    private func configureDataSource() {
        let compilation = compilationRegister()
        let categories = categoriesRegister()
        let mostPopular = MostPopularRegister()
        let catagoriesHeader = categoriesHeaderRegister()
        let mostPopularHeader = MostPopularHeaderRegister()
        
        dataSource = UICollectionViewDiffableDataSource<Sections, String>(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            switch Sections(rawValue: indexPath.section)! {
            case .compilation:
                return collectionView.dequeueConfiguredReusableCell(using: compilation, for: indexPath, item: "Comp")
            case .categories:
                return collectionView.dequeueConfiguredReusableCell(using: categories, for: indexPath, item: "All")
            case .mostPopular:
                return collectionView.dequeueConfiguredReusableCell(using: mostPopular, for: indexPath, item: "Most")
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
    
    //MARK: - Snapshot
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Sections, String>()
        
        snapshot.appendSections([.compilation, .categories, .mostPopular])
        let compilateionItem = ["Comp"]
        let categoriesItem = ["Categ"]
        let popularItem = ["Popular"]
        snapshot.appendItems(compilateionItem, toSection: .compilation)
        snapshot.appendItems(categoriesItem, toSection: .categories)
        snapshot.appendItems(popularItem, toSection: .mostPopular)
        
        dataSource?.apply(snapshot, animatingDifferences: true)
        
    }


}


//MARK: - SwiftUI
import SwiftUI
struct Provider_HomeViewController : PreviewProvider {
    static var previews: some View {
        ContainterView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainterView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            return HomeViewController()
        }
        
        typealias UIViewControllerType = UIViewController
        
        
        let viewController = HomeViewController()
        func makeUIViewController(context: UIViewControllerRepresentableContext<Provider_HomeViewController.ContainterView>) -> HomeViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: Provider_HomeViewController.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<Provider_HomeViewController.ContainterView>) {
            
        }
    }
    
}
