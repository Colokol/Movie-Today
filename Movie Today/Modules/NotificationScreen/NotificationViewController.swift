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
        label.text = "Time Interval"
        label.textColor = .white
        label.font = UIFont.montserratMedium(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.locale = Locale(identifier: "en_GB")
        return picker
    }()
    
    private lazy var showNotificationsStack: UIStackView = {
        createStack(arrangedSubviews: [showNotificationsLabel, switcher], axis: .horizontal)
    }()
    
    private lazy var verticalStack: UIStackView = {
        createStack(arrangedSubviews: [messagesNotificationsLabel, showNotificationsStack, exceptionsButton, horizontalStack], axis: .vertical)
    }()
    
    private lazy var horizontalStack: UIStackView = {
        createStack(arrangedSubviews: [timeIntervalLabel, datePicker], axis: .horizontal)
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
        setupDatePicker()
        getDateToPicker()
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
    
    private func setupDatePicker() {
        datePicker.addTarget(self, action: #selector(datePickerChanged), for: .valueChanged)
    }
    
    private func getDateToPicker() {
        if let dateData = UserDefaults.standard.data(forKey: "selectedDate"),
           let date = try? NSKeyedUnarchiver.unarchivedObject(ofClass: NSDate.self, from: dateData) as Date? {
            datePicker.date = date
        }
    }
    
    //MARK: - Actions
    
    @objc private func datePickerChanged() {
        if switcher.isOn {
            let selectedDate = datePicker.date
            let dateData = try? NSKeyedArchiver.archivedData(withRootObject: selectedDate, requiringSecureCoding: false)
            UserDefaults.standard.set(dateData, forKey: "selectedDate")
            notificationMananger.sendNotification(at: selectedDate)
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
