//
//  TrailerController.swift
//  Movie Today
//
//  Created by macbook on 01.01.2024.
//

import UIKit
import WebKit

final class TrailerController: UIViewController {
    
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
    private let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "heart"), for: .normal)
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
        setupView()
        setupConst()
        collectionViewConfigure()
        presenter.config()
        presenter.getActors()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Trailer"
    }
    
    private func setupView() {
        view.addSubviews(webView, titleView, stack, header)
        stack.addArrangedSubview(descriptionTitle)
        stack.addArrangedSubview(descriptionTextView)
        view.backgroundColor = .background
        webView.backgroundColor = .clear
        webView.layer.cornerRadius = 15
        webView.clipsToBounds = true
    }
    
    private func setupNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: likeButton)
        button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        likeButton.addTarget(self, action: #selector(likeAction), for: .touchUpInside)
    }
    
    private func configView(with model: Doc) {
        titleView.config(with: model)
        descriptionTextView.text = model.description
    }
    
    private func setupConst() {
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            webView.heightAnchor.constraint(equalToConstant: 180),
            
            titleView.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 12),
            titleView.leadingAnchor.constraint(equalTo: webView.leadingAnchor),
            titleView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: 50),
            titleView.heightAnchor.constraint(equalToConstant: 44),
            
            stack.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 32),
            stack.leadingAnchor.constraint(equalTo: webView.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: webView.trailingAnchor),
            stack.heightAnchor.constraint(equalToConstant: 300),
            
            header.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 25),
            header.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            header.trailingAnchor.constraint(lessThanOrEqualTo: stack.trailingAnchor),
            header.heightAnchor.constraint(equalToConstant: 20)
            
            
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
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: webView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: webView.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func likeAction() {
        //MARK: - Добавление в вишлист
    }
}

extension TrailerController: TrailerViewProtocol {
    func updateActors() {
        collectionView.reloadData()
    }
    
    func update(with model: Doc, text: String) {
        titleView.config(with: model)
        descriptionTextView.text = model.description
        if let youtubeURL = URL(string: "https://www.youtube.com/embed/\(text)?playsinline=1") {
                   webView.load(URLRequest(url: youtubeURL))
               }
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







