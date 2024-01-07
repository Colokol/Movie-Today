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
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    private let button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .soft
        button.frame = .init(x: 0, y: 0, width: 24, height: 24)
        button.layer.cornerRadius = button.bounds.size.width / 2
        return button
    }()
    
    var presenter: MovieListPresenterProtocol!
    
    //MARK: - LyfeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        configureActivityIndicator()
        configureCollectionView()
        configureDataSource()
        presenter.updateController()
        view.backgroundColor = .background
    }
    
    //MARK: - NavBarSetup
    private func setupNavBar() {
        title = "Movie List"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]

        appearance.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        
        button.addTarget(self, action: #selector(backButton), for: .touchUpInside)
    }
    
    @objc func backButton() {
        navigationController?.popViewController(animated: true)
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
    private func categoriesRegister() -> UICollectionView.CellRegistration<CategoriesCell, Categories> {
        return UICollectionView.CellRegistration<CategoriesCell, Categories> { (cell, indexPath, item) in
            cell.config(with: item)
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
//MARK: - MovieViewProtocol
extension MovieListController: MovieViewProtocol {
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
        var snapshot = NSDiffableDataSourceSnapshot<MovieListSections, Item>()
        snapshot.appendSections([.categories, .popular])
        let categories = presenter.categories.compactMap { Item(categories: $0)}
        snapshot.appendItems(categories, toSection: .categories)
        if let popular = presenter.movies?.compactMap({ Item(movieModel: $0)}) {
            snapshot.appendItems(popular, toSection: .popular)
        }
        
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    
}
//MARK: - CollectionViewDelegate
extension MovieListController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            presenter.didSelectItem(at: indexPath)

        } else if indexPath.section == 1 {
            //MARK: - ТУТ ПЕРЕХОД К DETAILCONTROLLER
            guard let model = presenter.movies?[indexPath.row] else { return }
            let vc = Builder.createDetailVC(model: model)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
