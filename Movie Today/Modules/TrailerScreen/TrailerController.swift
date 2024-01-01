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
    
    private var collectionView: UICollectionView!
    private let videoID = "F478PvRt74Y"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConst()
        collectionViewConfigure()
        
        if let youtubeURL = URL(string: "https://www.youtube.com/embed/\(videoID)?playsinline=1") {
                   webView.load(URLRequest(url: youtubeURL))
               }
    }
    
    private func setupView() {
        view.addSubviews(webView, titleView, stack)
        stack.addArrangedSubview(descriptionTitle)
        stack.addArrangedSubview(descriptionTextView)
        view.backgroundColor = .background
        webView.backgroundColor = .clear
        webView.layer.cornerRadius = 15
        webView.clipsToBounds = true
        
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
            stack.heightAnchor.constraint(equalToConstant: 174),
            
        ])
    }
    
    //MARK: - CollectionView configure
    private func collectionViewConfigure() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.backgroundColor = .red
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 24),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: webView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: webView.trailingAnchor),
        ])
    }
}


//MARK: - SwiftUI
import SwiftUI
struct Provider_TrailerController : PreviewProvider {
    static var previews: some View {
        ContainterView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainterView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            return TrailerController()
        }
        
        typealias UIViewControllerType = UIViewController
        
        
        let viewController = TrailerController()
        func makeUIViewController(context: UIViewControllerRepresentableContext<Provider_TrailerController.ContainterView>) -> TrailerController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: Provider_TrailerController.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<Provider_TrailerController.ContainterView>) {
            
        }
    }
    
}
