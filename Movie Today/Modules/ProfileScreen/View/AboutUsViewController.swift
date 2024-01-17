//
//  AboutUsViewController.swift
//  Movie Today
//
// Над проектом работали
/* Uladzislau Yatskevich - https://github.com/Colokol
    Anna Zaitsava - https://github.com/AnnaZaitsava
    Nikita Yakovenko - https://github.com/Nikita06122002
    Yuri Krasnov - https://github.com/KrasnovYuri
    Timofey Spodeneyko - https://github.com/TSpodeneyko
    Nikita Semennikov - https://github.com/SemennikovNA */

import UIKit
import SafariServices

final class AboutUsViewController: UIViewController {

    //MARK: - User interface elements
    
    // Label's
    private lazy var teamLeaderLabel = UILabel(text: "Team leader", font: .montserratSemiBold(ofSize: 20), textColor: .whiteGray, textAlignment: .left, numberOfLines: 0)
    private lazy var uladzislauY = UILabel(text: "Uladzislau Yatskevich", font: .montserratMedium(ofSize: 16), textColor: .white, textAlignment: .left, numberOfLines: 0)
    private lazy var teamLabel = UILabel(text: "Team", font: .montserratSemiBold(ofSize: 20), textColor: .whiteGray, textAlignment: .left, numberOfLines: 0)
    private lazy var annaZ = UILabel(text: "Anna Zaitsava", font: .montserratMedium(ofSize: 16), textColor: .white, textAlignment: .left, numberOfLines: 0)
    private lazy var nikitaY = UILabel(text: "Nikita Yakovenko", font: .montserratMedium(ofSize: 16), textColor: .white, textAlignment: .left, numberOfLines: 0)
    private lazy var yuriK = UILabel(text: "Yuri Krasnov", font: .montserratMedium(ofSize: 16), textColor: .white, textAlignment: .left, numberOfLines: 0)
    private lazy var timofeyS = UILabel(text: "Timofey Spodeneyko", font: .montserratMedium(ofSize: 16), textColor: .white, textAlignment: .left, numberOfLines: 0)
    private lazy var nikitaS = UILabel(text: "Nikita Semennikov", font: .montserratMedium(ofSize: 16), textColor: .white, textAlignment: .left, numberOfLines: 0)
    
    // Button's
    private lazy var uladzislauButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "git"), for: .normal)
        button.backgroundColor = .whiteGray
        return button
    }()
    private lazy var annaButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "git"), for: .normal)
        button.backgroundColor = .whiteGray
        return button
    }()
    private lazy var nikitaYButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "git"), for: .normal)
        button.backgroundColor = .whiteGray
        return button
    }()
    private lazy var yuriButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "git"), for: .normal)
        button.backgroundColor = .whiteGray
        return button
    }()
    private lazy var timofeyButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "git"), for: .normal)
        button.backgroundColor = .whiteGray
        return button
    }()
    private lazy var nikitaSButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "git"), for: .normal)
        button.backgroundColor = .whiteGray
        return button
    }()
    
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
        navigationItem.title = "About the team"
        navigationController?.navigationBar.tintColor = .white
        
        // Setup view
        view.backgroundColor = .background
        view.addSubviews(teamLeaderLabel, uladzislauY, teamLabel, annaZ, nikitaY, yuriK, timofeyS, nikitaS)
        view.addSubviews(uladzislauButton, annaButton, nikitaYButton, yuriButton, timofeyButton, nikitaSButton)
        
        // Setup button's
        uladzislauButton.layer.cornerRadius = 10
        annaButton.layer.cornerRadius = 10
        nikitaYButton.layer.cornerRadius = 10
        yuriButton.layer.cornerRadius = 10
        timofeyButton.layer.cornerRadius = 10
        nikitaSButton.layer.cornerRadius = 10
        
        // Button's target
        uladzislauButton.addTarget(self, action: #selector(uladzislauPresentGit), for: .touchUpInside)
        annaButton.addTarget(self, action: #selector(annaPresentGit), for: .touchUpInside)
        nikitaYButton.addTarget(self, action: #selector(nikitaYPresentGit), for: .touchUpInside)
        yuriButton.addTarget(self, action: #selector(yuriPresentGit), for: .touchUpInside)
        timofeyButton.addTarget(self, action: #selector(timofeyPresentGit), for: .touchUpInside)
        nikitaSButton.addTarget(self, action: #selector(nikitaSPresentGit), for: .touchUpInside)
    }
    
    //MARK: - @objc methods
    
    @objc func uladzislauPresentGit() {
        guard let url = URL(string: "https://github.com/Colokol") else { return }
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true)
    }
    
    @objc func annaPresentGit() {
        guard let url = URL(string: "https://github.com/AnnaZaitsava") else { return }
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true)
    }
    
    @objc func nikitaYPresentGit() {
        guard let url = URL(string: "https://github.com/Nikita06122002") else { return }
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true)
    }
    
    @objc func yuriPresentGit() {
        guard let url = URL(string: "https://github.com/KrasnovYuri") else { return }
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true)
    }
    
    @objc func timofeyPresentGit() {
        guard let url = URL(string: "https://github.com/TSpodeneyko") else { return }
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true)
    }
    
    @objc func nikitaSPresentGit() {
        guard let url = URL(string: "https://github.com/SemennikovNA") else { return }
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true)
    }
}

private extension AboutUsViewController {
    
    enum Constants {
        static let tenPoints: CGFloat = 10
        static let twentyPoints: CGFloat = 20
        static let thirtyPoints: CGFloat = 30
        static let sixtyPoints: CGFloat = 60
        static let buttonHeight: CGFloat = 30
        static let buttonWidth: CGFloat = 30
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
            // Label's constraints
            // Team leader label
            teamLeaderLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.thirtyPoints),
            teamLeaderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.twentyPoints),
            teamLeaderLabel.heightAnchor.constraint(equalToConstant: Constants.teamLeaderLabelHeight),
            teamLeaderLabel.widthAnchor.constraint(equalToConstant: Constants.teamLeaderLabelWidth),
            
            // Uladzislau Yatskevich label
            uladzislauY.topAnchor.constraint(equalTo: teamLeaderLabel.bottomAnchor, constant: Constants.tenPoints),
            uladzislauY.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.twentyPoints),
            uladzislauY.heightAnchor.constraint(equalToConstant: Constants.teamLeaderLabelHeight),
        
            
            // Team label
            teamLabel.topAnchor.constraint(equalTo: uladzislauY.bottomAnchor, constant: Constants.thirtyPoints),
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
            
            // Button's constraints
            // Uladzislau Yatskevich button
            uladzislauButton.topAnchor.constraint(equalTo: teamLeaderLabel.bottomAnchor, constant: Constants.tenPoints),
            uladzislauButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.twentyPoints),
            uladzislauButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            uladzislauButton.widthAnchor.constraint(equalToConstant: Constants.buttonWidth),
            
            // Anna Zaitsava button
            annaButton.topAnchor.constraint(equalTo: teamLabel.bottomAnchor, constant: Constants.tenPoints),
            annaButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.twentyPoints),
            annaButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            annaButton.widthAnchor.constraint(equalToConstant: Constants.buttonWidth),
            
            // Nikita Yakovenko button
            nikitaYButton.topAnchor.constraint(equalTo: annaButton.bottomAnchor, constant: Constants.tenPoints),
            nikitaYButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.twentyPoints),
            nikitaYButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            nikitaYButton.widthAnchor.constraint(equalToConstant: Constants.buttonWidth),
            
            // Yuri Krasnov button
            yuriButton.topAnchor.constraint(equalTo: nikitaYButton.bottomAnchor, constant: Constants.tenPoints),
            yuriButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.twentyPoints),
            yuriButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            yuriButton.widthAnchor.constraint(equalToConstant: Constants.buttonWidth),
            
            // Timofey Spodeneyko button
            timofeyButton.topAnchor.constraint(equalTo: yuriButton.bottomAnchor, constant: Constants.tenPoints),
            timofeyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.twentyPoints),
            timofeyButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            timofeyButton.widthAnchor.constraint(equalToConstant: Constants.buttonWidth),
            
            // Nikita Semennikov button
            nikitaSButton.topAnchor.constraint(equalTo: timofeyButton.bottomAnchor, constant: Constants.tenPoints),
            nikitaSButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.twentyPoints),
            nikitaSButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            nikitaSButton.widthAnchor.constraint(equalToConstant: Constants.buttonWidth),
        ])
    }
}
