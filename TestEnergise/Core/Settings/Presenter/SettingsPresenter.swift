//
//  SettingsPresenter.swift
//  TestEnergise
//
//  Created by Andrii Kyrychenko on 07/08/2025.
//

import UIKit
import StoreKit

class SettingsPresenter: SettingsPresenterProtocol {
    
    weak var view: SettingsViewProtocol?
    
    func viewDidLoad() {
        
        let rateButton = ButtonViewModel(
            title: NSLocalizedString("rate_the_app", comment: "Rate the app button title")) {
                
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                    SKStoreReviewController.requestReview(in: windowScene)
                }
        }
        
        let shareButton = ButtonViewModel(
            title: NSLocalizedString("share_the_app", comment: "Share the app button title")) {
                
                let appId = "id1234567890"
                if let url = URL(string: "https://apps.apple.com/app/TestEnergise/\(appId)") {
                    self.view?.showShareSheet(with: [url])
                }
                
        }
        
        let contactButton = ButtonViewModel(
            title: NSLocalizedString("contact_us", comment: "Contact us button title")) {
                
                let urlString = "https://healthy-metal-aa6.notion.site/iOS-Developer-12831b2ac19680068ac3fcd91252b819"
                if let url = URL(string: urlString) {
                    self.view?.openURL(url)
                }
            
        }
        
        view?.setupUI(with: [rateButton, shareButton, contactButton])
    }
 
}
