//
//  PreviewChatViewProtocol.swift
//  TestEnergise
//
//  Created by Andrii Kyrychenko on 02/08/2025.
//

import Foundation

protocol PreviewChatViewProtocol: AnyObject {
    
    func displayMessages(_ messages: [Message])
    func showErrorMessage(_ message: String)
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func setChatTitle(_ title: String)
    
}
