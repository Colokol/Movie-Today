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
    let termsLabel = UILabel(font: .boldSystemFont(ofSize: 15))
    let secondTermsLabel = UILabel(font: .boldSystemFont(ofSize: 15))
    let termsTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        return textView
    }()
    let secondTermsTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
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
    
    func setupConstraints() {
        
    }
}
