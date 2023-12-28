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
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.alwaysBounceVertical = true
        scroll.showsVerticalScrollIndicator = false
        scroll.frame = view.bounds
        return scroll
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        return contentView
    }()
    private lazy var termsLabel = UILabel(font: .boldSystemFont(ofSize: 20), textColor: .white, textAlignment: .left)
    private lazy var secondTermsLabel = UILabel(font: .boldSystemFont(ofSize: 18), textColor: .white, textAlignment: .left)
    private lazy var termsTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = .background
        textView.font = .systemFont(ofSize: 18)
        textView.textColor = .white
        return textView
    }()
    private lazy var secondTermsTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = .background
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
        view.backgroundColor = .background
        view.addSubviews(scrollView)
        scrollView.addSubviews(contentView)
        contentView.addSubviews(termsLabel, termsTextView, secondTermsLabel, secondTermsTextView)
        
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
            
            // Scroll view
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            // Content view
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Terms label
            termsLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constans.twentyPoints),
            termsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constans.leadingLabelInsets),
            termsLabel.heightAnchor.constraint(equalToConstant: Constans.labelHeight),
            termsLabel.widthAnchor.constraint(equalToConstant: Constans.termsLabelWidth),
            
            // Terms text view
            termsTextView.topAnchor.constraint(equalTo: termsLabel.bottomAnchor, constant: Constans.tenPoints),
            termsTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constans.leadingLabelInsets),
            termsTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constans.leadingLabelInsets),
            termsTextView.heightAnchor.constraint(equalToConstant: Constans.textViewHeight),
            
            // Second terms label
            secondTermsLabel.topAnchor.constraint(equalTo: termsTextView.bottomAnchor, constant: Constans.twentyPoints),
            secondTermsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constans.leadingLabelInsets),
            secondTermsLabel.heightAnchor.constraint(equalToConstant: Constans.labelHeight),
            secondTermsLabel.widthAnchor.constraint(equalToConstant: Constans.textViewHeight),
            
            // Second terms text view
            secondTermsTextView.topAnchor.constraint(equalTo: secondTermsLabel.bottomAnchor, constant: Constans.tenPoints),
            secondTermsTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constans.leadingLabelInsets),
            secondTermsTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constans.leadingLabelInsets),
            secondTermsTextView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
