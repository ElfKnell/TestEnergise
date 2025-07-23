//
//  SettingsViewController.swift
//  TestEnergise
//
//  Created by Andrii Kyrychenko on 22/07/2025.
//

import UIKit
import StoreKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGroupedBackground
        title = NSLocalizedString("settings", comment: "")
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        
        let rateButton = createButton(title: NSLocalizedString("rate_the_app", comment: ""), action: #selector(rateApp))
        let shareButton = createButton(title: NSLocalizedString("share_the_app", comment: ""), action: #selector(shareApp))
        let contactButton = createButton(title: NSLocalizedString("contact_us", comment: ""), action: #selector(contactUs))

        stack.addArrangedSubview(rateButton)
        stack.addArrangedSubview(shareButton)
        stack.addArrangedSubview(contactButton)
        
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32)
        ])
    }
    
    private func createButton(title: String, action: Selector) -> UIButton {
        
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
    
    @objc
    private func rateApp() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            SKStoreReviewController.requestReview(in: windowScene)
        }
    }
    
    @objc
    private func shareApp() {
        let appURL = URL(string: "https://apps.apple.com/app/idYOUR_APP_ID")!
        let activityVC = UIActivityViewController(activityItems: [appURL], applicationActivities: nil)
        present(activityVC, animated: true)
    }
    
    @objc
    private func contactUs() {
        let str = "https://healthy-metal-aa6.notion.site/iOS-Developer-12831b2ac19680068ac3fcd91252b819"
        if let url = URL(string: str) {
            UIApplication.shared.open(url)
        }
    }
}
