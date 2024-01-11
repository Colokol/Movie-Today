//
//  SearchResult.swift
//  Movie Today
//
//  Created by macbook on 28.12.2023.
//

import UIKit

final class SearchResult: UIViewController {
    
    private var collectionView: UICollectionView!
    private let errorView = NotFoundView()
    var presenter: ResultPresenterProtocol!
    weak var delegate: SearchResultDelegate?
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewConfigure()
        errorView.isHidden = true
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
        view.addSubviews(collectionView, errorView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            errorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
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
        return presenter.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmCell.identifier, for: indexPath) as? FilmCell else { return UICollectionViewCell() }
        if let model = presenter.results?[indexPath.row] {
            cell.configSearch(with: model)
            
        }
        return cell
    }
    
    
}

extension SearchResult: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //MARK: - ТУТ ПЕРЕХОД К DETAILCONTROLLER
        guard let model = presenter.results?[indexPath.row] else { return }
        delegate?.openDetailWithModel(model)
    }
}

extension SearchResult: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    
}

extension SearchResult: ResultViewProtocol {
    func showError(_ show: Bool) {
        errorView.isHidden = !show
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    func update() {
        if presenter.results?.count == 0 {
            presenter.showError(false)
        } else {
            presenter.showError(true)
        }
        
    }
}
