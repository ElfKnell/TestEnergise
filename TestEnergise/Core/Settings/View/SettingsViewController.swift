//
//  SettingsViewController.swift
//  TestEnergise
//
//  Created by Andrii Kyrychenko on 22/07/2025.
//

import UIKit
import StoreKit

class SettingsViewController: UIViewController {
    
    var presenter: SettingsPresenterProtocol!
    
    lazy var settingsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGroupedBackground
        title = NSLocalizedString("settings", comment: "")
        
        presenter.view = self
        setupSettingsStackView()
        presenter.viewDidLoad()
    }
    
    private func setupSettingsStackView() {
        
        view.addSubview(settingsStackView)
        
        NSLayoutConstraint.activate([
            settingsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            settingsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            settingsStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            settingsStackView.widthAnchor.constraint(lessThanOrEqualToConstant: 300),
            settingsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func createButton(title: String, action: @escaping () -> Void) -> UIButton {
        
        let button = UIButton(type: .system)
        
        var config = button.configuration ?? .plain()
        config.title = title
        config.baseForegroundColor = .label
        config.background.backgroundColor = .systemBlue
        config.cornerStyle = .medium
        config.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 20, bottom: 15, trailing: 20)
        button.configuration = config
        
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let buttonAction = UIAction { _ in action() }
        button.addAction(buttonAction, for: .touchUpInside)
        
        button.accessibilityLabel = title
        button.accessibilityTraits = .button
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.1
        button.layer.shadowRadius = 3
        
        return button
    }
    
}
