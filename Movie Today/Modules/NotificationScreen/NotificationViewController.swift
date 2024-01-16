//
//  NotificationViewController.swift
//  Movie Today
//
//  Created by Юрий on 09.01.2024.
//

import UIKit

class NotificationViewController: UIViewController {
    
    //MARK: - Properties
    
    let notificationMananger = NotificationManager()

    //MARK: - UI Elements
    
    private let messagesNotificationsLabel: UILabel = {
        UILabel(text: "Messages Notifications", font: .montserratMedium(ofSize: 15), textColor: .gray) }()
    
    private let showNotificationsLabel: UILabel = {
        UILabel(text: "Show Notifications", font: .montserratMedium(ofSize: 20), textColor: .white)
    }()
    
    private let exceptionsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Exceptions", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.montserratMedium(ofSize: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let switcher: UISwitch = {
        let switcher = UISwitch()
        switcher.onTintColor = .blueAccent
        switcher.translatesAutoresizingMaskIntoConstraints = false
        return switcher
    }()
    
    private let timeIntervalLabel: UILabel = {
        let label = UILabel()
        label.text = "Time Interval: 0 sec"
        label.textColor = .white
        label.font = UIFont.montserratMedium(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let timeIntervalStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.wraps = false
        stepper.autorepeat = true
        stepper.stepValue = 60
        stepper.maximumValue = 3600
        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
    }()
    
    private lazy var showNotificationsStack: UIStackView = {
        createStack(arrangedSubviews: [showNotificationsLabel, switcher], axis: .horizontal)
    }()
    
    private lazy var verticalStack: UIStackView = {
        createStack(arrangedSubviews: [messagesNotificationsLabel, showNotificationsStack, exceptionsButton, horizontalStack], axis: .vertical)
    }()
    
    private lazy var horizontalStack: UIStackView = {
        createStack(arrangedSubviews: [timeIntervalLabel, timeIntervalStepper], axis: .horizontal)
    }()
    

    
    //MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Notification"
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.montserratMedium(ofSize: 20) ?? 20
        ]
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupSwitcher()
        setupStepper()
        setConstraints()
        addStepperTarget()
    }
    

    
    //MARK: - Private Methods
    
    private func addStepperTarget() {
        timeIntervalStepper.addTarget(self, action: #selector(stepperAction), for: .touchUpInside)
    }
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
    
    private func setupStepper() {
        let savedInterval = UserDefaults.standard.integer(forKey: "selectedTimeInterval")
        if savedInterval > 0 {
            timeIntervalStepper.value = Double(savedInterval)
            timeIntervalLabel.text = "Time Interval: \(savedInterval) sec"
        }
    }
    
    //MARK: - Actions
    
    @objc private func stepperAction() {
        let interval = Int(timeIntervalStepper.value)
        timeIntervalLabel.text = "Time Interval: \(interval) sec"
        UserDefaults.standard.set(interval, forKey: "selectedTimeInterval")
        if switcher.isOn {
            notificationMananger.sendNotification(after: interval)
        }
    }
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
