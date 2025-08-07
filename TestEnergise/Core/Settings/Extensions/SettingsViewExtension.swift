//
//  SettingsViewExtension.swift
//  TestEnergise
//
//  Created by Andrii Kyrychenko on 07/08/2025.
//

import Foundation
import UIKit

extension SettingsViewController: SettingsViewProtocol {
    
    func setupUI(with buttonViewModels: [ButtonViewModel]) {
        settingsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for viewModel in buttonViewModels {
            let button = createButton(title: viewModel.title, action: viewModel.action)
            settingsStackView.addArrangedSubview(button)
        }
    }
    
    func showShareSheet(with activityItems: [Any]) {
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        
        if let popover = activityVC.popoverPresentationController {
            popover.sourceView = self.view
            popover.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.minY, width: 0, height: 0)
            popover.permittedArrowDirections = []
        }
        
        present(activityVC, animated: true)
    }
    
    func openURL(_ url: URL) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
}
