//
//  NotificationViewController.swift
//  Movie Today
//
//  Created by Юрий on 09.01.2024.
//

import UIKit

class NotificationViewController: UIViewController {

    
    //MARK: - UI Elements
    
    private let messagesNotificationsLabel: UILabel = {
        UILabel(text: "Messages Notifications", font: .systemFont(ofSize: 14), textColor: .gray) }()
    
    private let showNotificationsLabel: UILabel = {
        UILabel(text: "Show Notifications", font: .systemFont(ofSize: 20), textColor: .white)
    }()
    
    private let exceptionsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Exceptions", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let switcher: UISwitch = {
        let switcher = UISwitch()
        switcher.onTintColor = .blueAccent
        switcher.translatesAutoresizingMaskIntoConstraints = false
        return switcher
    }()
    
    private lazy var showNotificationsStack: UIStackView = {
        createStack(arrangedSubviews: [showNotificationsLabel, switcher], axis: .horizontal)
    }()
    
    private lazy var verticalStack: UIStackView = {
        createStack(arrangedSubviews: [messagesNotificationsLabel, showNotificationsStack, exceptionsButton], axis: .vertical)
    }()
    
    //MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Notification"
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)
        ]
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupSwitcher()
        setConstraints()
    }
    

    
    //MARK: - Private Methods
    
    private func createStack(arrangedSubviews views: [UIView], axis: NSLayoutConstraint.Axis) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = axis
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }

    private func setupViews() {
        view.backgroundColor = UIColor.background
        view.addSubview(verticalStack)
    }
    
    private func setupSwitcher() {
        switcher.isOn = UserDefaults.standard.bool(forKey: "switchState")
        switcher.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
    }
    
    //MARK: - Actions
    
    @objc private func switchValueChanged() {
        UserDefaults.standard.set(switcher.isOn, forKey: "switchState")
    }
    
    // MARK: - Set Constraints
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            exceptionsButton.widthAnchor.constraint(equalTo: exceptionsButton.titleLabel!.widthAnchor),
            
            verticalStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            verticalStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            verticalStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
            
        ])
    }
    
}
