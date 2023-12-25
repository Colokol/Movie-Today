//
//  PrivacyView.swift
//  Movie Today
//
//  Created by Nikita on 25.12.2023.
//

import UIKit

class PrivacyViewController: UIViewController {

    //MARK: - Properties
    let termsLabelText = "Terms"
    let termsText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. Sapien, consequat ultrices morbi orci semper sit nulla. Leo auctor ut etiam est, amet aliquet ut vivamus. Odio vulputate est id tincidunt fames. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. Sapien, consequat ultrices morbi orci semper sit nulla. Leo auctor ut etiam est, amet aliquet ut vivamus. Odio vulputate est id tincidunt fames."
    let secondTermsLabelText = "Changes to the Service and/or Terms:"
    let secondTermsText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. Sapien, consequat ultrices morbi orci semper sit nulla. Leo auctor ut etiam est, amet aliquet ut vivamus. Odio vulputate est id tincidunt fames. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. Sapien, consequat ultrices morbi orci semper sit nulla. Leo auctor ut etiam est, amet aliquet ut vivamus. Odio vulputate est id tincidunt fames."
    
    
    //MARK: - User interface elements
    let termsLabel = UILabel(font: .boldSystemFont(ofSize: 20), textColor: .white)
    let secondTermsLabel = UILabel(font: .boldSystemFont(ofSize: 15), textColor: .white)
    let termsTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = .blue
        textView.font = .systemFont(ofSize: 18)
        textView.textColor = .white
        return textView
    }()
    let secondTermsTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = .blue
        textView.font = .systemFont(ofSize: 18)
        textView.textColor = .white
        return textView
    }()
    
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call function's
        setupView()
        setupConstraints()
    }
    
    //MARK: - Private methods
    
    private func setupView() {
        
        // Setup view
        view.backgroundColor = .blue
        view.addSubviews(termsLabel, termsTextView, secondTermsLabel, secondTermsTextView)
        
        // Setup label's
        termsLabel.text = termsLabelText
        secondTermsLabel.text = secondTermsText
        
        // Setup text view's
        termsTextView.text = termsText
        secondTermsTextView.text = secondTermsText
    }
}

//MARK: - Extension

extension PrivacyViewController {
    
    enum Constans {
        static let labelHeight: CGFloat = 17
        static let twentyPoints: CGFloat = 20
        static let leadingLabelInsets: CGFloat = 24
        static let termsLabelWidth: CGFloat = 45
        static let topInsets: CGFloat = 120
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            // Terms label
            termsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constans.topInsets),
            termsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constans.leadingLabelInsets),
            termsLabel.heightAnchor.constraint(equalToConstant: Constans.labelHeight),
            termsLabel.widthAnchor.constraint(equalToConstant: Constans.termsLabelWidth),
            
            // Terms text view
            termsTextView.topAnchor.constraint(equalTo: termsLabel.bottomAnchor, constant: Constans.twentyPoints),
            termsTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constans.leadingLabelInsets),
            termsTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constans.leadingLabelInsets),
            termsTextView.heightAnchor.constraint(equalToConstant: 320),
            
        ])
    }
}

#Preview() {
    PrivacyViewController()
}
