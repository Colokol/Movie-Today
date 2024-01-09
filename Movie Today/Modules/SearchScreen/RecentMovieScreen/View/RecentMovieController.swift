//
//  RecentMovieController.swift
//  Movie Today
//
//  Created by macbook on 09.01.2024.
//

import UIKit

final class RecentMovieController: UIViewController {
    
    private var collectionView: UICollectionView!
    var presenter: RecentMoviePresenterProtocol!
    
    private let button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .soft
        button.frame = .init(x: 0, y: 0, width: 24, height: 24)
        button.layer.cornerRadius = button.bounds.size.width / 2
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewConfigure()
        setupNavBar()
        view.backgroundColor = .background
    }
    
    //MARK: - NavBarSetup
    private func setupNavBar() {
        title = "Recent Movies"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]

        appearance.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        
        button.addTarget(self, action: #selector(backButton), for: .touchUpInside)
    }
    
    //MARK: - Configure CollectionView
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
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    @objc private func backButton() {
        navigationController?.popViewController(animated: true)
    }
    
}
//MARK: - Delegate 
extension RecentMovieController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = presenter.getFilmId(with: indexPath)
        presenter.getMovieWithId(id) { model in
            guard let model = model else { return }
            let vc = Builder.createDetailVC(model: model)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

//MARK: - Data Source
extension RecentMovieController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.recentCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmCell.identifier, for: indexPath) as? FilmCell else { return UICollectionViewCell() }
        let movie = presenter.recentMovies[indexPath.row]
        cell.configRecent(with: movie)
        return cell
    }
    
    
}

//MARK: - DelegateFlowLayout
extension RecentMovieController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 330, height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

extension RecentMovieController: RecentMovieView {
    func update() {
        collectionView.reloadData()
    }
    
    
}
