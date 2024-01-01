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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConst()
    }
    
    private func setupView() {
        view.addSubviews(webView, titleView)
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
            titleView.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
