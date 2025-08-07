//
//  ChatViewControllerExtension.swift
//  TestEnergise
//
//  Created by Andrii Kyrychenko on 04/08/2025.
//

import UIKit

extension ChatViewController: ChatViewProtocol {
    
    func clearMessageInput() {
        inputField.text = ""
    }
    
    func showErrorMessage(_ message: String) {
        let alert = UIAlertController(title: NSLocalizedString("error", comment: "Error alert title"),
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    func showLoadingIndicator() {
        activityIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        activityIndicator.stopAnimating()
    }
    
    func appendNewMessage(_ message: Message) {
        
        collectionView.performBatchUpdates {
            let newIndexPath = IndexPath(item: presenter.messages.count - 1, section: 0)
            collectionView.insertItems(at: [newIndexPath])
        } completion: { _ in
            self.scrollToBottom()
        }

    }
    
    func scrollToBottom() {
        
        guard presenter.messages.count > 0 else { return }
        let lastItemIndex = presenter.messages.count - 1
        let lastIndexPath = IndexPath(item: lastItemIndex, section: 0)
        collectionView.scrollToItem(at: lastIndexPath, at: .bottom, animated: true)
    }
    
    func displayMessages(_ messages: [Message]) {
        collectionView.reloadData()
        scrollToBottom()
    }
}
