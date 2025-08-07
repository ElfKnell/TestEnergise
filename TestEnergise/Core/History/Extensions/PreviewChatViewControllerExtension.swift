//
//  PreviewChatViewControllerExtension.swift
//  TestEnergise
//
//  Created by Andrii Kyrychenko on 03/08/2025.
//

import UIKit

extension PreviewChatViewController: PreviewChatViewProtocol {
    
    func displayMessages(_ messages: [Message]) {
        collectionView.reloadData()
    }
    
    func showErrorMessage(_ message: String) {
        let alert = UIAlertController(title: NSLocalizedString("error", comment: "Error alert title"), message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func showLoadingIndicator() {
        activityIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        activityIndicator.stopAnimating()
    }
    
    func setChatTitle(_ title: String) {
        self.title = title
    }

}
