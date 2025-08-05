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
        setupSettingsStackView()
    }
    
    private func setupSettingsStackView() {
        
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        
        let rateButton = createButton(title: NSLocalizedString("rate_the_app",
                                                               comment: "Rate the app button title"),
                                      action: #selector(rateApp))
        let shareButton = createButton(title: NSLocalizedString("share_the_app",
                                                                comment: "Share the app button title"),
                                       action: #selector(shareApp))
        let contactButton = createButton(title: NSLocalizedString("contact_us",
                                                                  comment: "Contact us button title"),
                                         action: #selector(contactUs))

        stack.addArrangedSubview(rateButton)
        stack.addArrangedSubview(shareButton)
        stack.addArrangedSubview(contactButton)
        
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            stack.widthAnchor.constraint(lessThanOrEqualToConstant: 300),
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func createButton(title: String, action: Selector) -> UIButton {
        
        let button = UIButton(type: .system)
        
        var config = button.configuration ?? .plain()
        config.title = title
        config.baseForegroundColor = .label
        config.background.backgroundColor = .systemBlue
        config.cornerStyle = .medium
        config.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 20, bottom: 15, trailing: 20)
        button.configuration = config
        
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.addTarget(self, action: action, for: .touchUpInside)
        button.accessibilityLabel = title
        button.accessibilityTraits = .button
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.1
        button.layer.shadowRadius = 3
        
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
        let appId = "id1234567890"
        guard let url = URL(string: "https://apps.apple.com/app/TestEnergise/\(appId)") else {
            return
        }
        
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        if let popover = activityVC.popoverPresentationController {
            popover.sourceView = self.view
            popover.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.minY, width: 0, height: 0)
            popover.permittedArrowDirections = []
        }
        
        present(activityVC, animated: true)
    }
    
    @objc
    private func contactUs() {
        let str = "https://healthy-metal-aa6.notion.site/iOS-Developer-12831b2ac19680068ac3fcd91252b819"
        if let url = URL(string: str), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}
