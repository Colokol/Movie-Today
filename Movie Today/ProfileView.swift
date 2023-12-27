//
//  ProfileView.swift
//  Movie Today
//
//  Created by Nikita on 27.12.2023.
//

import UIKit

class ProfileView: UIView {
    
    
    //MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Call function's
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    //MARK: - Private methods
    
    private func setupView() {
        self.backgroundColor = .blue
    }
}

private extension ProfileView {
    
    func setupConstraints() {
        
    }
}

#Preview() {
    ProfileViewController()
}
