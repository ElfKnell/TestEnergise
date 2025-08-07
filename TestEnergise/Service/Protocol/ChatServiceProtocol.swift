//
//  ChatServiceProtocol.swift
//  TestEnergise
//
//  Created by Andrii Kyrychenko on 02/08/2025.
//

import Foundation

protocol ChatServiceProtocol: AnyObject {
    
    func fetchChats() -> [Chat]
    func createChat() -> Chat
    func delete(_ chat: Chat)
    
}
