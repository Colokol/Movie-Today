//
//  AboutUsViewController.swift
//  Movie Today
//
//  Created by Nikita on 14.01.2024.
//
//
// Uladzislau Yatskevich - https://github.com/Colokol
// Anna Zaitsava - https://github.com/AnnaZaitsava
// Nikita Yakovenko - https://github.com/Nikita06122002
// Yuri Krasnov - https://github.com/KrasnovYuri
// Timofey Spodeneyko - https://github.com/TSpodeneyko
// Nikita Semennikov - https://github.com/SemennikovNA
//
//

import UIKit

final class AboutUsViewController: UIViewController {

    //MARK: - User interface elements
    
    // Label's
    private lazy var titleLabel = UILabel(text: "About the team", font: .montserratSemiBold(ofSize: 20), textColor: .whiteGray, textAlignment: .center, numberOfLines: 0)
    private lazy var teamLeaderLabel = UILabel(text: "Team leader", font: .montserratSemiBold(ofSize: 20), textColor: .whiteGray, textAlignment: .left, numberOfLines: 0)
    private lazy var uladzislauLabel = UILabel(text: "Uladzislau Yatskevich", font: .montserratMedium(ofSize: 16), textColor: .white, textAlignment: .left, numberOfLines: 0)
    private lazy var teamLabel = UILabel(text: "Team", font: .montserratSemiBold(ofSize: 20), textColor: .whiteGray, textAlignment: .left, numberOfLines: 0)
    private lazy var annaZ = UILabel(text: "Anna Zaitsava", font: .montserratMedium(ofSize: 16), textColor: .white, textAlignment: .left, numberOfLines: 0)
    private lazy var nikitaY = UILabel(text: "Nikita Yakovenko", font: .montserratMedium(ofSize: 16), textColor: .white, textAlignment: .left, numberOfLines: 0)
    private lazy var yuriK = UILabel(text: "Yuri Krasnov", font: .montserratMedium(ofSize: 16), textColor: .white, textAlignment: .left, numberOfLines: 0)
    private lazy var timofeyS = UILabel(text: "Timofey Spodeneyko", font: .montserratMedium(ofSize: 16), textColor: .white, textAlignment: .left, numberOfLines: 0)
    private lazy var nikitaS = UILabel(text: "Nikita Semennikov", font: .montserratMedium(ofSize: 16), textColor: .white, textAlignment: .left, numberOfLines: 0)
    
    // Button's
    
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Call method's
        setupView()
        setupConstraints()
    }
    
    //MARK: - Private methods
    
    private func setupView() {
        // Setup view
        view.backgroundColor = .background
        view.addSubviews(titleLabel, teamLeaderLabel, uladzislauLabel, teamLabel, annaZ, nikitaY, yuriK, timofeyS, nikitaS)
        
    }
}

private extension AboutUsViewController {
    
    enum Constants {
        static let tenPoints: CGFloat = 10
        static let twentyPoints: CGFloat = 20
        static let thirtyPoints: CGFloat = 30
        static let sixtyPoints: CGFloat = 60
        static let titleLabelHeight: CGFloat = 50
        static let titleLabwlWidth: CGFloat = 200
        static let teamLeaderLabelHeight: CGFloat = 30
        static let teamLeaderLabelWidth: CGFloat = 130
        static let uladzislauLabelHeight: CGFloat = 50
        static let uladzislauLabelWidth: CGFloat = 400
        static let annaZLabelHeight: CGFloat = 30
        static let annaZLabelWidth: CGFloat = 200
        static let nikitaYLabelHeight: CGFloat = 30
        static let nikitaYLabelWidth: CGFloat = 200
        static let yuriKLabelHeight: CGFloat = 30
        static let yuriKLabelWidth: CGFloat = 200
        static let timofeySLabelHeight: CGFloat = 30
        static let timofeySLabelWidth: CGFloat = 200
        static let nikitaSLabelHeight: CGFloat = 30
        static let nikitaySLabelWidth: CGFloat = 200
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            // Title label
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.twentyPoints),
            titleLabel.heightAnchor.constraint(equalToConstant: Constants.titleLabelHeight),
            titleLabel.widthAnchor.constraint(equalToConstant: Constants.titleLabwlWidth),
            
            // Team leader label
            teamLeaderLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.sixtyPoints),
            teamLeaderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.twentyPoints),
            teamLeaderLabel.heightAnchor.constraint(equalToConstant: Constants.teamLeaderLabelHeight),
            teamLeaderLabel.widthAnchor.constraint(equalToConstant: Constants.teamLeaderLabelWidth),
            
            // Uladzislau Yatskevich label
            uladzislauLabel.topAnchor.constraint(equalTo: teamLeaderLabel.bottomAnchor, constant: Constants.tenPoints),
            uladzislauLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.twentyPoints),
            uladzislauLabel.heightAnchor.constraint(equalToConstant: Constants.teamLeaderLabelHeight),
            
            // Team label
            teamLabel.topAnchor.constraint(equalTo: uladzislauLabel.bottomAnchor, constant: Constants.thirtyPoints),
            teamLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.twentyPoints),
            teamLabel.heightAnchor.constraint(equalToConstant: Constants.teamLeaderLabelHeight),
            teamLabel.widthAnchor.constraint(equalToConstant: Constants.teamLeaderLabelWidth),
            
            // Anna Zaitsava label
            annaZ.topAnchor.constraint(equalTo: teamLabel.bottomAnchor, constant: Constants.tenPoints),
            annaZ.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.twentyPoints),
            annaZ.heightAnchor.constraint(equalToConstant: Constants.annaZLabelHeight),
            annaZ.widthAnchor.constraint(equalToConstant: Constants.annaZLabelWidth),
            
            // Nikita Yakovenko label
            nikitaY.topAnchor.constraint(equalTo: annaZ.bottomAnchor, constant: Constants.tenPoints),
            nikitaY.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.twentyPoints),
            nikitaY.heightAnchor.constraint(equalToConstant: Constants.nikitaYLabelHeight),
            nikitaY.widthAnchor.constraint(equalToConstant: Constants.nikitaYLabelWidth),
            
            // Yuri Krasnov label
            yuriK.topAnchor.constraint(equalTo: nikitaY.bottomAnchor, constant: Constants.tenPoints),
            yuriK.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.twentyPoints),
            yuriK.heightAnchor.constraint(equalToConstant: Constants.yuriKLabelHeight),
            yuriK.widthAnchor.constraint(equalToConstant: Constants.yuriKLabelWidth),
            
            // Timofey Spodeneyko label
            timofeyS.topAnchor.constraint(equalTo: yuriK.bottomAnchor, constant: Constants.tenPoints),
            timofeyS.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.twentyPoints),
            timofeyS.heightAnchor.constraint(equalToConstant: Constants.timofeySLabelHeight),
            timofeyS.widthAnchor.constraint(equalToConstant: Constants.timofeySLabelWidth),
            
            // Nikita Semennikov label
            nikitaS.topAnchor.constraint(equalTo: timofeyS.bottomAnchor, constant: Constants.tenPoints),
            nikitaS.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.twentyPoints),
            nikitaS.heightAnchor.constraint(equalToConstant: Constants.nikitaSLabelHeight),
            nikitaS.widthAnchor.constraint(equalToConstant: Constants.nikitaYLabelWidth),
        ])
    }
}

#Preview() {
    AboutUsViewController()
}
