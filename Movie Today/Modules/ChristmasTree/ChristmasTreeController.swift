//
//  ChristmasTree.swift
//  Movie Today
//
//  Created by macbook on 04.01.2024.
//

import UIKit

final class ChristmasTreeController: UIViewController {
    
    private let imageView: UIImageView = {
      let image = UIImageView()
        image.image = UIImage(named: "tree")
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        return image
    }()
    private let button1 = Button()
    private let button2 = Button()
    private let button3 = Button()
    private let button4 = Button()
    private let button5 = Button()
    private let button6 = Button()
    private let button7 = Button()
    private let button8 = Button()
    private let button9 = Button()
    private let button10 = Button()
    private let button11 = Button()
    private let button12 = Button()
    private let button13 = Button()
    private let button14 = Button()
    private let button15 = Button()
    private let button16 = Button()
    private let button17 = Button()
    private let button18 = Button()
    private let button19 = Button()
    private let button20 = Button()
    private let button21 = Button()
    private let button22 = Button()
    private let button23 = Button()
    private let button24 = Button()
    private let button25 = Button()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConst()
        addTargets()
        view.backgroundColor = .background
    }
    private func addTargets() {
        let buttons = [button1, button2, button3, button4, button5, button6, button7, button8, button9, button10, button11, button12, button13, button14, button15, button16, button17, button18, button19, button20, button21, button22, button23, button24, button25]
        for button in buttons {
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        }
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        
    }
    private func setupView() {
        view.addSubviews(imageView)
        imageView.addSubviews(button1, button2, button3, button4, button5, button6, button7, button8, button9, button10, button11, button12, button13, button14, button15, button16, button17, button18, button19, button20, button21, button22, button23, button24, button25)
        imageView.backgroundColor = .clear
    }
    
    private func setupConst() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            button1.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: -8),
            button1.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: -170),
            
            button2.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: -40),
            button2.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: -130),
            
            button3.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: 35),
            button3.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: -105),
            
            button4.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: -70),
            button4.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: -75),
            
            button5.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: -8),
            button5.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: -70),
            
            button6.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: 45),
            button6.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: -50),
            
            button7.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: -5),
            button7.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: -10),
            
            button8.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: -50),
            button8.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: -20),
            
            button9.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: -100),
            button9.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: -20),
            
            button10.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: 45),
            button10.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 5),
            
            button11.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: 85),
            button11.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: -10),
            
            button12.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: 75),
            button12.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 55),
            
            button13.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: 15),
            button13.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 45),
            
            button14.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: -35),
            button14.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 65),
            
            button15.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: -80),
            button15.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 30),
            
            button16.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: -118),
            button16.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 95),
            
            button17.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: -118),
            button17.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 95),
            
            button18.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: -60),
            button18.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 95),
            
            button19.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            button19.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 105),
            
            button20.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: 108),
            button20.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 90),
            
            button21.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: 108),
            button21.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 90),
            
            button22.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: 58),
            button22.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 135),
            
            button22.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: 58),
            button22.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 135),
            
            button23.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: 16),
            button23.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 170),
            
            button24.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: -53),
            button24.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 150),
            
            button25.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: -110),
            button25.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 150),
        ])
    }

    
}


//MARK: - SwiftUI
import SwiftUI
struct Provider_ChristmasTreeController : PreviewProvider {
    static var previews: some View {
        ContainterView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainterView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            return ChristmasTreeController()
        }
        
        typealias UIViewControllerType = UIViewController
        
        
        let viewController = ChristmasTreeController()
        func makeUIViewController(context: UIViewControllerRepresentableContext<Provider_ChristmasTreeController.ContainterView>) -> ChristmasTreeController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: Provider_ChristmasTreeController.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<Provider_ChristmasTreeController.ContainterView>) {
            
        }
    }
    
}
