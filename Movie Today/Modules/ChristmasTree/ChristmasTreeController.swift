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
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = false
        return image
    }()
    private let button1 = Button(image: UIImage(named: "ball")!)
    private let button2 = Button(image: UIImage(named: "ball3")!)
    private let button3 = Button(image: UIImage(named: "ball5")!)
    private let button4 = Button(image: UIImage(named: "ball2")!)
    private let button5 = Button(image: UIImage(named: "dev")!)
    private let button6 = Button(image: UIImage(named: "ball3")!)
    private let button7 = Button(image: UIImage(named: "ball4")!)
    private let button8 = Button(image: UIImage(named: "ball2")!)
    private let button9 = Button(image: UIImage(named: "ball2")!)
    private let button10 = Button(image: UIImage(named: "ball2")!)
    private let button11 = Button(image: UIImage(named: "ball")!)
    private let button12 = Button(image: UIImage(named: "ball6")!)
    private let button13 = Button(image: UIImage(named: "ball5")!)
    private let button14 = Button(image: UIImage(named: "ball3")!)
    private let button15 = Button(image: UIImage(named: "dev")!)
    private let button16 = Button(image: UIImage(named: "ball")!)
    private let button17 = Button(image: UIImage(named: "ball6")!)
    private let button18 = Button(image: UIImage(named: "ball5")!)
    private let button19 = Button(image: UIImage(named: "ball")!)
    private let button20 = Button(image: UIImage(named: "ball4")!)
    private let button21 = Button(image: UIImage(named: "ball3")!)
    private let button22 = Button(image: UIImage(named: "dev")!)
    private let button23 = Button(image: UIImage(named: "ball4")!)
    private let button24 = Button(image: UIImage(named: "ball6")!)
    private let button25 = Button(image: UIImage(named: "ball3")!)
    private let button26 = Button(image: UIImage(named: "gift")!)
    private let button27 = Button(image: UIImage(named: "gift2")!)
    private let button28 = Button(image: UIImage(named: "gift3")!)
    


    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConst()
        addTargets()
        view.backgroundColor = .background
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
   
    }
    private func addTargets() {
        let buttons = [button1, button2, button3, button4, button5, button6, button7, button8, button9, button10, button11, button12, button13, button14, button15, button16, button17, button18, button19, button20, button21, button22, button23, button24, button25, button26, button27, button28]
        for button in buttons {
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        }
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        print("TAP")

    }
    private func setupView() {
        view.addSubviews(imageView)
        imageView.addSubviews(button1, button2, button3, button4, button5, button6, button7, button8, button9, button10, button11, button12, button13, button14, button15, button16, button17, button18, button19, button20, button21, button22, button23, button24, button25, button26, button27, button28)
        imageView.backgroundColor = .clear
        imageView.isUserInteractionEnabled = true
    }
    
    private func setupConst() {
        NSLayoutConstraint.activate([
  
                imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
                imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                imageView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor),
                imageView.widthAnchor.constraint(equalToConstant: 500),
                imageView.heightAnchor.constraint(equalToConstant: 600),

            button1.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: -8),
            button1.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: -170),
            button1.heightAnchor.constraint(equalToConstant: 50),
            button1.widthAnchor.constraint(equalToConstant: 50),
            
            button2.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: -40),
            button2.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: -130),
                button2.heightAnchor.constraint(equalToConstant: 50),
                button2.widthAnchor.constraint(equalToConstant: 50),
            
            button3.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: 45),
            button3.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: -125),
                button3.heightAnchor.constraint(equalToConstant: 60),
                button3.widthAnchor.constraint(equalToConstant: 60),
            
            button4.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: -70),
            button4.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: -75),
                button4.heightAnchor.constraint(equalToConstant: 50),
                button4.widthAnchor.constraint(equalToConstant: 50),
            
            button5.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: 18),
            button5.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: -75),
                button5.heightAnchor.constraint(equalToConstant: 50),
                button5.widthAnchor.constraint(equalToConstant: 50),
            
            button6.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: 65),
            button6.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: -50),
                button6.heightAnchor.constraint(equalToConstant: 40),
                button6.widthAnchor.constraint(equalToConstant: 40),
            
            button7.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: -5),
            button7.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: -10),
                button7.heightAnchor.constraint(equalToConstant: 70),
                button7.widthAnchor.constraint(equalToConstant: 70),
            
            button8.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: 105),
            button8.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: -20),
                button8.heightAnchor.constraint(equalToConstant: 40),
                button8.widthAnchor.constraint(equalToConstant: 40),
            
            button9.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: -100),
            button9.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 40),
                button9.heightAnchor.constraint(equalToConstant: 40),
                button9.widthAnchor.constraint(equalToConstant: 40),
            
            button10.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: 55),
            button10.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 5),
                button10.heightAnchor.constraint(equalToConstant: 40),
                button10.widthAnchor.constraint(equalToConstant: 40),
            
            button11.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: -90),
            button11.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: -10),
                button11.heightAnchor.constraint(equalToConstant: 50),
                button11.widthAnchor.constraint(equalToConstant: 50),
            
            button12.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: 95),
            button12.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 55),
                button12.heightAnchor.constraint(equalToConstant: 50),
                button12.widthAnchor.constraint(equalToConstant: 50),
            
            button13.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: 15),
            button13.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 55),
                button13.heightAnchor.constraint(equalToConstant: 60),
                button13.widthAnchor.constraint(equalToConstant: 60),
            
            button14.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: -45),
            button14.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 35),
                button14.heightAnchor.constraint(equalToConstant: 50),
                button14.widthAnchor.constraint(equalToConstant: 50),
            
            button15.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: 90),
            button15.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 190),
                button15.heightAnchor.constraint(equalToConstant: 50),
                button15.widthAnchor.constraint(equalToConstant: 50),
            
            button16.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: -118),
            button16.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 95),
            button16.heightAnchor.constraint(equalToConstant: 50),
            button16.widthAnchor.constraint(equalToConstant: 50),
            
            button17.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: -160),
            button17.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 145),
                button17.heightAnchor.constraint(equalToConstant: 50),
                button17.widthAnchor.constraint(equalToConstant: 50),
            
            button18.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: -60),
            button18.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 95),
                button18.heightAnchor.constraint(equalToConstant: 60),
                button18.widthAnchor.constraint(equalToConstant: 60),
            
            button19.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            button19.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 105),
                button19.heightAnchor.constraint(equalToConstant: 50),
                button19.widthAnchor.constraint(equalToConstant: 50),
            
            button20.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: 128),
            button20.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 90),
                button20.heightAnchor.constraint(equalToConstant: 60),
                button20.widthAnchor.constraint(equalToConstant: 60),
            
            button21.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: 28),
            button21.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 180),
                button21.heightAnchor.constraint(equalToConstant: 50),
                button21.widthAnchor.constraint(equalToConstant: 50),
            
            button22.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: 58),
            button22.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 135),
            
            button22.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: 58),
            button22.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 135),
                button22.heightAnchor.constraint(equalToConstant: 50),
                button22.widthAnchor.constraint(equalToConstant: 50),
            
            button23.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: 146),
            button23.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 170),
                button23.heightAnchor.constraint(equalToConstant: 60),
                button23.widthAnchor.constraint(equalToConstant: 60),
            
            button24.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: -40),
            button24.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 160),
                button24.heightAnchor.constraint(equalToConstant: 60),
                button24.widthAnchor.constraint(equalToConstant: 60),
            
            button25.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: -110),
            button25.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 170),
                button25.heightAnchor.constraint(equalToConstant: 50),
                button25.widthAnchor.constraint(equalToConstant: 50),
                
                button26.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: -120),
                button26.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 250),
                button26.heightAnchor.constraint(equalToConstant: 200),
                button26.widthAnchor.constraint(equalToConstant: 200),
                
                button27.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: -10),
                button27.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 260),
                button27.heightAnchor.constraint(equalToConstant: 150),
                button27.widthAnchor.constraint(equalToConstant: 150),
                
                button28.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: 100),
                button28.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 260),
                button28.heightAnchor.constraint(equalToConstant: 150),
                button28.widthAnchor.constraint(equalToConstant: 150),
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
