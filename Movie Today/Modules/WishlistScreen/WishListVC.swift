//
//  WishListVC.swift
//  Movie Today
//
//  Created by Anna Zaitsava on 27.12.23.
//

import UIKit

class WishListVC: UIViewController {
    
    var presenter: WishListPresenterProtocol!

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(WishlistCell.self, forCellWithReuseIdentifier: WishlistCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        title = "Wishlist"
        setupUI()
    }
    
    private func setupUI() {
        view.addSubviews(collectionView)
        
        let offset: CGFloat = 24
        
        NSLayoutConstraint.activate([
            
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: offset),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: offset),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -offset),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

}

//MARK: Extensions CollectionView

extension WishListVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.favoriteMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WishlistCell.identifier, for: indexPath) as! WishlistCell
        
        let favoriteMovie = presenter.favoriteMovies[indexPath.section]
        cell.configure(with: favoriteMovie)
        
        cell.likeButtonPressedHandler = { [weak self] in
            guard let self = self else { return }
            cell.isInWishlist = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                self.presenter.likePressed(favoriteMovie)
            }
        }
        return cell
    }
}

extension WishListVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.width)
        let cellHeight: CGFloat = 107
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

// MARK: - WishListViewProtocol
extension WishListVC: WishListViewProtocol {
  
    func update() {
        collectionView.reloadData()
    }

    func changeHeartColor() {

    }
}

