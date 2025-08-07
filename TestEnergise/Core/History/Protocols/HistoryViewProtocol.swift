//
//  HistoryViewProtocol.swift
//  TestEnergise
//
//  Created by Andrii Kyrychenko on 31/07/2025.
//

import Foundation

protocol HistoryViewProtocol: AnyObject {
    
    func displayChats(_ previews: [ChatPreview])
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func showErrorMessage(_ message: String)
    func reloadSection(_ section: Int)
    func deleteSection(_ section: IndexSet)
    func navigateToChatDetail(for chat: Chat)
    
}
