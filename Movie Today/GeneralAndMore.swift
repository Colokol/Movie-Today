//
//  General&More.swift
//  Movie Today
//
//  Created by Nikita on 27.12.2023.
//

import UIKit

class GeneralAndMore: UIView {
    
    //MARK: - User interface element

    private lazy var viewLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 25)
        return label
    }()
    private lazy var firstButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitleColor(.gray, for: .normal)
        button.setTitle("Hi", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        return button
    }()
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    private lazy var secondButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitleColor(.gray, for: .normal)
        button.setTitle("Hi", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        return button
    }()
    
    
    //MARK: - Initialize
    
    init(labelText: String?, firstButtonTitle: String?, firstButtonImage: String?, secondButtonTitle: String?, secondButtonImage: String?) {
        super.init(frame: .infinite)
        viewLabel.text = labelText
        
        
        // Call function's
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private method
    
    private func setupView() {
        self.addSubviews(viewLabel, firstButton, separatorView, secondButton)
    }
}

private extension GeneralAndMore {
    
    enum Constans {
        static let twoPoints: CGFloat = 2
        static let tenPoints: CGFloat = 10
        static let twentyPoints: CGFloat = 20
        static let thiryPoints: CGFloat = 30
        static let fiftyFivePoints: CGFloat = 55
        static let ninetyPoints: CGFloat = 90
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // View label
            viewLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Constans.tenPoints),
            viewLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constans.tenPoints),
            viewLabel.heightAnchor.constraint(equalToConstant: Constans.twentyPoints),
            viewLabel.widthAnchor.constraint(equalToConstant: Constans.ninetyPoints),
            
            // First button
            firstButton.topAnchor.constraint(equalTo: viewLabel.bottomAnchor, constant: Constans.twentyPoints),
            firstButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constans.tenPoints),
            firstButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constans.tenPoints),
            firstButton.heightAnchor.constraint(equalToConstant: Constans.fiftyFivePoints),
            
            // Separator view
            separatorView.topAnchor.constraint(equalTo: firstButton.bottomAnchor, constant: Constans.tenPoints),
            separatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constans.thiryPoints),
            separatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constans.thiryPoints),
            separatorView.heightAnchor.constraint(equalToConstant: Constans.twoPoints),
            
            // Second button
            secondButton.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: Constans.tenPoints),
            secondButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constans.tenPoints),
            secondButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constans.tenPoints),
            secondButton.heightAnchor.constraint(equalToConstant: Constans.fiftyFivePoints),
        ])
    }
}
#Preview() {
    ProfileViewController()
}
