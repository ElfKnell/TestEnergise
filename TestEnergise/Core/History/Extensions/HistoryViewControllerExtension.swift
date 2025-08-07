//
//  HistoryViewControllerExtension.swift
//  TestEnergise
//
//  Created by Andrii Kyrychenko on 01/08/2025.
//

import UIKit

extension HistoryViewController: HistoryViewProtocol {
    
    func displayChats(_ previews: [ChatPreview]) {
        collectionView.reloadData()
    }
    
    func showLoadingIndicator() {
        activityIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        activityIndicator.stopAnimating()
    }
    
    func showErrorMessage(_ message: String) {
        let alert = UIAlertController(title: NSLocalizedString("error", comment: "Error alert title"), message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func reloadSection(_ section: Int) {
        collectionView.reloadSections(IndexSet(integer: section))
    }
    
    func deleteSection(_ section: IndexSet) {
        collectionView.performBatchUpdates {
            collectionView.deleteSections(section)
        } completion: { isFinihed in
            if isFinihed && self.collectionView.numberOfSections == 0 {
                print("data is empty")
            } else {
                self.collectionView.reloadData()
            }
        }
    }
    
    func navigateToChatDetail(for chat: Chat) {
        
        let chatPresenter = PreviewChatPresenter(chat: chat, messageService: (presenter as! HistoryPresenter).messageService)
        let chatVC = PreviewChatViewController(presenter: chatPresenter)
        
        navigationController?.pushViewController(chatVC, animated: true)
    }
    
    
}
