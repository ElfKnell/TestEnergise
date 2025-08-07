//
//  MessageSerciceProtocol.swift
//  TestEnergise
//
//  Created by Andrii Kyrychenko on 02/08/2025.
//

import Foundation

protocol MessageServiceProtocol: AnyObject {
    
    func fetchMessages() -> [Message]
    func fetchMessages(chat: Chat) -> [Message]
    func createMessage(text: String, chat: Chat, isUserMessage: Bool) -> Message?
    
}
