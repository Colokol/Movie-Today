//
//  SearchResultController.swift
//  Movie Today
//
//  Created by macbook on 05.01.2024.
//

import UIKit

final class SearchResultController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<SearchSections, Item>?
    private let errorView = NotFoundView()
    var presenter: SearchResultPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        errorView.isHidden = true
        configureCollectionView()
        configureDataSource()
    }
    //MARK: - Метод создания лейаута
    private func createLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            guard let sectionKind = SearchSections(rawValue: sectionIndex) else { return nil }
            
            let section: NSCollectionLayoutSection
            switch sectionKind {
            case .actors:
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(120), heightDimension: .absolute(100))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(105))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

                
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                return section
                
            case .related:
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(355), heightDimension: .absolute(175))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                
                
                section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 0, bottom: 30, trailing: 0)
                return section
            }
        }
    }
    
    //MARK: - CollectionView Configure
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView?.backgroundColor = .clear
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        view.addSubviews(collectionView, errorView)
        collectionView.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            errorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    //MARK: - Методы регистрации ячеек
    
    private func actorCellRegister() -> UICollectionView.CellRegistration<ActorsCell, Person> {
        return UICollectionView.CellRegistration<ActorsCell, Person> { (cell, indexPath, item) in
            cell.config(with: item)
        }
    }
    
    private func relatedCellRegister() -> UICollectionView.CellRegistration<FilmCell, DocSearch> {
        return UICollectionView.CellRegistration<FilmCell, DocSearch> { (cell, indexPath, item) in
            cell.configSearch(with: item)
            
        }
    }
    
    //MARK: - Настройка dataSource
    
    func configureDataSource() {
        //Регистрация ячеек
        let actors = actorCellRegister()
        let related = relatedCellRegister()
        dataSource = UICollectionViewDiffableDataSource<SearchSections, Item>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            switch SearchSections(rawValue: indexPath.section)! {
            case .actors:
                print("ячейка актеров создана")
                return collectionView.dequeueConfiguredReusableCell(using: actors, for: indexPath, item: item.actor)
            case .related:
                print("ячейка фильмов создана")
                return collectionView.dequeueConfiguredReusableCell(using: related, for: indexPath, item: item.search)
            }
        })
    }
    
    //MARK: - SnapShot
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<SearchSections, Item>()
        snapshot.appendSections([.actors, .related])
        if let actors = presenter.actors?.compactMap({ Item(actor: $0)}) {
            snapshot.appendItems(actors, toSection: .actors)
            print("в снэпшот добавлены актеры")
        }
        if let related = presenter.movies?.compactMap({ Item(search: $0)}) {
            snapshot.appendItems(related, toSection: .related)
            print("в снэпшот добавлены фильмы")
        }
        
        
        dataSource?.apply(snapshot, animatingDifferences: true)
        
    }

}

extension SearchResultController: UICollectionViewDelegate {
    
}

extension SearchResultController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

extension SearchResultController: SearchResultViewProtocol {
    func showError(_ show: Bool) {
        if show {
            errorView.isHidden = true
        } else {
            errorView.isHidden = false
        }
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    func update() {
        applySnapshot()
    }
    
    
}
