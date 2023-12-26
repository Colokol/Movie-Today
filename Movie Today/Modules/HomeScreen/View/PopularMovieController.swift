//
//  PopularMovieController.swift
//  Movie Today
//
//  Created by macbook on 26.12.2023.
//

import UIKit

final class PopularMovieController: UIViewController {
    
    private var collectionView: UICollectionView!
    private let array = ["Spider Man", "Spider Man", "Spider Man", "Spider Man", "Spider Man"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewConfigure()
        
    }
    
    private func collectionViewConfigure() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
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

extension PopularMovieController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 330, height: 150)
    }
}

extension PopularMovieController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let label = UILabel(frame: cell.bounds)
        label.text = array[indexPath.row]
        label.textAlignment = .center
        label.textColor = .red
        cell.backgroundColor = .white
        cell.contentView.addSubview(label)
        
        return cell
    }
    
    
}
