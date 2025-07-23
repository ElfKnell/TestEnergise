//
//  HistoryPresenter.swift
//  TestEnergise
//
//  Created by Andrii Kyrychenko on 21/07/2025.
//

import Foundation

class HistoryPresenter {
    
    var previews: [ChatPreview] = []
    
    let chatService: ChatService
    let messageService: MessageService
    
    init(chatService: ChatService, messageService: MessageService) {
        self.chatService = chatService
        self.messageService = messageService
    }
    
    func fetchingChats() {
        let chats = chatService.fetchingChats()
        
        previews = chats.map { chat in
            let allMessages = messageService.fetchingMessager(chat: chat)
            let firstTwo = Array(allMessages.prefix(2))
            return ChatPreview(chat: chat, messages: firstTwo)
        }
    }
    
    func deleteChat(at index: Int) {
        let chat = previews[index].chat
        chatService.delete(chat)
        previews.remove(at: index)
    }
}
