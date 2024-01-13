//
//  TrailerController.swift
//  Movie Today
//
//  Created by macbook on 01.01.2024.
//

import UIKit
import WebKit

final class TrailerController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let webView = WKWebView()
    private let titleView = TitleView()
    var presenter: TrailerPresenterProtocol!
    private let descriptionTitle: UILabel = {
        let label = UILabel()
        label.font = .montserratSemiBold(ofSize: 16)
        label.text = "Synopsis"
        label.textColor = .white
        return label
    }()
    private let descriptionTextView: UITextView = {
        let text = UITextView()
        text.text = "THE BATMAN is an edgy, action-packed thriller that depicts Batman in his early years, struggling to balance rage with righteousness as he investigates a disturbing mystery that has terrorized Gotham. Robert Pattinson delivers a raw, intense portrayal of Batman as a disillusioned, desperate vigilante awakened by the realization.."
        text.isEditable = false
        text.isScrollEnabled = false
        text.font = .montserratRegular(ofSize: 14)
        text.textColor = .white
        text.backgroundColor = .clear
        return text
    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 5
        return stack
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .soft
        button.frame = .init(x: 0, y: 0, width: 24, height: 24)
        button.layer.cornerRadius = button.bounds.size.width / 2
        return button
    }()
    
    private let header: UILabel = {
        let label = UILabel()
        label.text = "Cast and Crew"
        label.font = .montserratSemiBold(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    private var collectionView: UICollectionView!
    private let videoID = "F478PvRt74Y"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.hidesBottomBarWhenPushed = false
        setupNavBar()
        collectionViewConfigure()
        setupView()
        setupConstraints()
        presenter.config()
        presenter.getActors()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Trailer"
    }
    
    private func setupView() {
        view.addSubviews(scrollView)
        scrollView.addSubviews(contentView)
        contentView.addSubviews(webView, titleView, stack, header, collectionView)
        stack.addArrangedSubview(descriptionTitle)
        stack.addArrangedSubview(descriptionTextView)
        scrollView.backgroundColor = .clear
        contentView.backgroundColor = .clear
        view.backgroundColor = .background
        webView.backgroundColor = .clear
        webView.layer.cornerRadius = 15
        webView.clipsToBounds = true
    }
    
    private func setupNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
    }
    
    private func configView(with model: Doc) {
        titleView.config(with: model)
        descriptionTextView.text = model.description
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            webView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            webView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            webView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            webView.heightAnchor.constraint(equalToConstant: 180),
            
            titleView.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 12),
            titleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            titleView.heightAnchor.constraint(equalToConstant: 44),
            
            stack.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 12),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            
            header.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 25),
            header.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            header.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            header.heightAnchor.constraint(equalToConstant: 20),
            
            collectionView.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            collectionView.heightAnchor.constraint(equalToConstant: 50),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    
    //MARK: - CollectionView configure
    private func collectionViewConfigure() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ActorCell.self, forCellWithReuseIdentifier: ActorCell.identifier)
        
    }
    
    
    @objc private func backAction() {
        navigationController?.popViewController(animated: true)
    }

}

extension TrailerController: TrailerViewProtocol {
    func updateActors() {
        collectionView.reloadData()
    }
    
    func update(with model: Doc) {
        titleView.config(with: model)
        descriptionTextView.text = model.description
        let videos = model.videos
        guard let trailers = videos?.trailers else { return }
        guard let url = trailers[0].url else { return }
        guard let videoURL = URL(string: url) else { return }
        webView.load(URLRequest(url: videoURL))
        
    }
    
    
}

extension TrailerController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.filmPersons?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActorCell.identifier, for: indexPath) as? ActorCell else { return UICollectionViewCell() }
        if let actor = presenter.filmPersons?[indexPath.row] {
            cell.config(with: actor)
        }
        return cell
    }
    
    
}

extension TrailerController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 45)
    }
    
    
    
}
