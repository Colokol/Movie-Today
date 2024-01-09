//
//  SearchResult.swift
//  Movie Today
//
//  Created by macbook on 28.12.2023.
//

import UIKit

final class SearchResult: UIViewController {
    
    var collectionView: UICollectionView!
    var results = [Doc]()
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewConfigure()
        view.backgroundColor = .background
        
        
    }
    //MARK: - CollectionView configure
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
//MARK: - DelegateFlowLayout
extension SearchResult: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 330, height: 150)
    }
}
//MARK: - DataSource
extension SearchResult: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmCell.identifier, for: indexPath) as? FilmCell else { return UICollectionViewCell() }
        cell.configSearch(with: results[indexPath.row])
        
        return cell
    }
    
    
}

extension SearchResult: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //MARK: - ТУТ ПЕРЕХОД К DETAILCONTROLLER
        let vc = Builder.createDetailVC(model: results[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)

    }
}

extension SearchResult: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    
}
