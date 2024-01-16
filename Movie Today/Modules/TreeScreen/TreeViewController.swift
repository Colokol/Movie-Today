//
//  TreeViewController.swift
//  Movie Today
//
//  Created by macbook on 15.01.2024.
//

import UIKit
import Lottie

final class TreeViewController: UIViewController {
    
    var presenter: TreePresenterProtocol!
    
    private var treeView = LottieAnimationView(name: "tree")
    private var fireWorkView = LottieAnimationView(name: "firework")
    private lazy var button = createButton()
    private lazy var buttonOne = createButton()
    private lazy var buttonTwo = createButton()
    private lazy var buttonThree = createButton()
    private lazy var buttonFour = createButton()
    private lazy var buttonFive = createButton()
    private lazy var buttonSix = createButton()
    private lazy var buttonSeven = createButton()
    private let recomendView = RecomendView()
    private var blur: UIVisualEffectView?

        
    override func viewDidLoad() {
        super.viewDidLoad()
        recomendView.isHidden = true
        treeAnimateConfig()
        fireworkAnimateConfig()
        setupView()
        setupConstraints()
        setupTargets()
        closeAction()
    }
    private func treeAnimateConfig() {
        treeView.contentMode = .scaleAspectFit
        treeView.loopMode = .loop
        treeView.animationSpeed = 0.5
        treeView.play()
    }
    
    private func fireworkAnimateConfig() {
        fireWorkView.backgroundColor = .clear
        fireWorkView.isHidden = true
        fireWorkView.contentMode = .scaleAspectFit
        fireWorkView.loopMode = .loop
        fireWorkView.animationSpeed = 0.5
    }
    
    private func closeAction() {
        recomendView.closeButtonAction = {
            self.hideRecomend()
            self.recomendView.clearView()
        }
    }
    
    private func createButton() -> UIButton {
        let button = UIButton()
        button.backgroundColor = .clear
        return button
    }
    
    private func setupTargets() {
        let buttonArray = [button, buttonOne, buttonTwo, buttonThree, buttonFour, buttonFive, buttonSix, buttonSeven]
        buttonArray.forEach { $0.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)}
    }
    
    private func setupView() {
        view.addSubviews(treeView, fireWorkView)
        view.addSubviews(recomendView)
        treeView.addSubviews(button, buttonOne, buttonTwo, buttonThree, buttonFour, buttonFive, buttonSix, buttonSeven)
        treeView.isUserInteractionEnabled = true
        view.backgroundColor = .background
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            fireWorkView.topAnchor.constraint(equalTo: view.topAnchor),
            fireWorkView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            fireWorkView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            fireWorkView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            treeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            treeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            treeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            treeView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            button.centerXAnchor.constraint(equalTo: treeView.centerXAnchor, constant: 0),
            button.centerYAnchor.constraint(equalTo: treeView.centerYAnchor, constant: -85),
            button.widthAnchor.constraint(equalToConstant: 30),
            button.heightAnchor.constraint(equalToConstant: 30),
            
            buttonOne.centerXAnchor.constraint(equalTo: treeView.centerXAnchor, constant: -20),
            buttonOne.centerYAnchor.constraint(equalTo: treeView.centerYAnchor, constant: -50),
            buttonOne.widthAnchor.constraint(equalToConstant: 20),
            buttonOne.heightAnchor.constraint(equalToConstant: 20),
            
            buttonTwo.centerXAnchor.constraint(equalTo: treeView.centerXAnchor, constant: 20),
            buttonTwo.centerYAnchor.constraint(equalTo: treeView.centerYAnchor, constant: -50),
            buttonTwo.widthAnchor.constraint(equalToConstant: 20),
            buttonTwo.heightAnchor.constraint(equalToConstant: 20),
            
            buttonThree.centerXAnchor.constraint(equalTo: treeView.centerXAnchor, constant: 30),
            buttonThree.centerYAnchor.constraint(equalTo: treeView.centerYAnchor),
            buttonThree.widthAnchor.constraint(equalToConstant: 20),
            buttonThree.heightAnchor.constraint(equalToConstant: 20),
            
            buttonFour.centerXAnchor.constraint(equalTo: treeView.centerXAnchor, constant: -10),
            buttonFour.centerYAnchor.constraint(equalTo: treeView.centerYAnchor, constant: 5),
            buttonFour.widthAnchor.constraint(equalToConstant: 20),
            buttonFour.heightAnchor.constraint(equalToConstant: 20),
            
            buttonFive.centerXAnchor.constraint(equalTo: treeView.centerXAnchor, constant: -30),
            buttonFive.centerYAnchor.constraint(equalTo: treeView.centerYAnchor, constant: 45),
            buttonFive.widthAnchor.constraint(equalToConstant: 20),
            buttonFive.heightAnchor.constraint(equalToConstant: 20),
            
            buttonSix.centerXAnchor.constraint(equalTo: treeView.centerXAnchor, constant: 15),
            buttonSix.centerYAnchor.constraint(equalTo: treeView.centerYAnchor, constant: 65),
            buttonSix.widthAnchor.constraint(equalToConstant: 20),
            buttonSix.heightAnchor.constraint(equalToConstant: 20),
            
            buttonSeven.centerXAnchor.constraint(equalTo: treeView.centerXAnchor, constant: 45),
            buttonSeven.centerYAnchor.constraint(equalTo: treeView.centerYAnchor, constant: 60),
            buttonSeven.widthAnchor.constraint(equalToConstant: 20),
            buttonSeven.heightAnchor.constraint(equalToConstant: 20),
            
            recomendView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recomendView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            recomendView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            recomendView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            recomendView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    @objc private func buttonAction() {
        print("tap")
        if blur == nil {
            self.presenter.getFilm()
            fireWorkView.play()
            showRecomend()
        } else {
            hideRecomend()
        }
    }
    
    private func showRecomend() {
        fireWorkView.isHidden = false
        fireWorkView.play()
        let blurEffect = UIBlurEffect(style: .regular)
        blur = UIVisualEffectView(effect: blurEffect)
        blur?.alpha = 0.4
        blur?.frame = self.view.bounds
        blur?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(blur!)
        self.view.bringSubviewToFront(recomendView)
        recomendView.isHidden = false
    }
    
    private func hideRecomend() {
        fireWorkView.stop()
        fireWorkView.isHidden = true
        recomendView.isHidden = true
        blur?.isHidden = true
        blur = nil
    }
}

extension TreeViewController: TreeViewProtocol {
    func update(with model: Doc) {
        recomendView.config(with: model)
    }
    
    
}
