//
//  ChatViewUpdating.swift
//  TestEnergise
//
//  Created by Andrii Kyrychenko on 21/07/2025.
//

import Foundation

protocol ChatViewProtocol: AnyObject {
    
    func displayMessages(_ messages: [Message])
    func clearMessageInput()
    func showErrorMessage(_ message: String)
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func appendNewMessage(_ message: Message)
    func scrollToBottom()
}
