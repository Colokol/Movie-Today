//
//  LanguageTableViewController.swift
//  Movie Today
//
//  Created by Юрий on 11.01.2024.
//

import UIKit

class LanguageTableViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private var selectedIndexPath: IndexPath?
    private let selectedLanguageKey = "SelectedLanguage"
    private var languages = Source.makeLanguageWithGroup()
    private let tableView: UITableView = .init(frame: .zero, style: .insetGrouped)
    
    // MARK: - View Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Language"
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)
        ]
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        tableView.register(LanguageCell.self, forCellReuseIdentifier: "LanguageCell")
        tableView.backgroundColor = .background
        tableView.dataSource = self
        tableView.delegate = self
        
        configureSelectedIndexPath()
    }
    
    // MARK: - Methods
    
    func configureSelectedIndexPath() {
        if let selectedLanguageName = UserDefaults.standard.string(forKey: selectedLanguageKey) {
            for (sectionIndex, section) in languages.enumerated() {
                for (rowIndex, language) in section.enumerated() {
                    if language.name == selectedLanguageName {
                        selectedIndexPath = IndexPath(row: rowIndex, section: sectionIndex)
                        break
                    }
                }
                if selectedIndexPath != nil {
                    break
                }
            }
        }
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
// MARK: - UITableViewDataSource

extension LanguageTableViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        languages[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageCell", for: indexPath) as! LanguageCell
        cell.selectionStyle = .none
        
        if let selectedIndexPath = selectedIndexPath {
            cell.isSelected = (indexPath == selectedIndexPath)
        } else {
            cell.isSelected = false
        }
        
        cell.configure(language: languages[indexPath.section][indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .darkGray
        header.textLabel?.font = UIFont.montserratSemiBold(ofSize: 15)
        header.textLabel?.text = header.textLabel?.text?.lowercased()
        
        if let text = header.textLabel?.text {
                let words = text.components(separatedBy: " ")
                let capitalizedWords = words.map { $0.prefix(1).capitalized + $0.dropFirst() }
                let capitalizedText = capitalizedWords.joined(separator: " ")
                header.textLabel?.text = capitalizedText
            }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: "Suggested Languages"
        case 1: "Other Language"
        default: nil
        }
    }
}

// MARK: - UITableViewDelegate

extension LanguageTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? LanguageCell {
            cell.isSelected = true
            selectedIndexPath = indexPath
            
            let selectedLanguage = languages[indexPath.section][indexPath.row]
            UserDefaults.standard.set(selectedLanguage.name, forKey: selectedLanguageKey)
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.borderColor = UIColor.soft.cgColor
        cell.layer.borderWidth = 0.5
    }
}
