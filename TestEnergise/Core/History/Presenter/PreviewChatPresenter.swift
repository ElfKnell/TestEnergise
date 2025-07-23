//
//  PreviewChatPresenter.swift
//  TestEnergise
//
//  Created by Andrii Kyrychenko on 21/07/2025.
//

import Foundation

class PreviewChatPresenter {
    
    let messageService: MessageService
    
    init(messageService: MessageService) {
        self.messageService = messageService
    }
    
    func fetchingMessages(_ chat: Chat) -> [String] {
        let messages = messageService.fetchingMessager(chat: chat)
        let messagesString = messages.map { $0.text ?? "" }
        return messagesString
    }
}
