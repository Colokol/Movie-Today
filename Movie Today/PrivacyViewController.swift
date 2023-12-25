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
    let secondTermsLabel = UILabel(font: .boldSystemFont(ofSize: 18), textColor: .white)
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
        secondTermsLabel.text = secondTermsLabelText
        
        // Setup text view's
        termsTextView.text = termsText
        secondTermsTextView.text = secondTermsText
    }
}

//MARK: - Extension

extension PrivacyViewController {
    
    enum Constans {
        static let labelHeight: CGFloat = 19
        static let tenPoints: CGFloat = 10
        static let twentyPoints: CGFloat = 20
        static let leadingLabelInsets: CGFloat = 24
        static let termsLabelWidth: CGFloat = 60
        static let topInsets: CGFloat = 60
        static let textViewHeight: CGFloat = 320
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            // Terms label
            termsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constans.topInsets),
            termsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constans.leadingLabelInsets),
            termsLabel.heightAnchor.constraint(equalToConstant: Constans.labelHeight),
            termsLabel.widthAnchor.constraint(equalToConstant: Constans.termsLabelWidth),
            
            // Terms text view
            termsTextView.topAnchor.constraint(equalTo: termsLabel.bottomAnchor, constant: Constans.tenPoints),
            termsTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constans.leadingLabelInsets),
            termsTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constans.leadingLabelInsets),
            termsTextView.heightAnchor.constraint(equalToConstant: Constans.textViewHeight),
            
            // Second terms label
            secondTermsLabel.topAnchor.constraint(equalTo: termsTextView.bottomAnchor, constant: Constans.twentyPoints),
            secondTermsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constans.leadingLabelInsets),
            secondTermsLabel.heightAnchor.constraint(equalToConstant: Constans.labelHeight),
            secondTermsLabel.widthAnchor.constraint(equalToConstant: Constans.textViewHeight),
            
            // Second terms text view
            secondTermsTextView.topAnchor.constraint(equalTo: secondTermsLabel.bottomAnchor, constant: Constans.tenPoints),
            secondTermsTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constans.leadingLabelInsets),
            secondTermsTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constans.leadingLabelInsets),
            
        ])
    }
}

#Preview() {
    PrivacyViewController()
}
