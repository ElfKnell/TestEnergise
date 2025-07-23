//
//  MessageService.swift
//  TestEnergise
//
//  Created by Andrii Kyrychenko on 19/07/2025.
//

import Foundation
import CoreData

class MessageService {
    
    let serviceContainer: ServiceContainer
    
    init() {
        self.serviceContainer = ServiceContainer.shared
    }
    
    func fetchingMessages() -> [Message] {
        let req = Message.fetchRequest()
        guard let messages = try? serviceContainer.persistentContainer.viewContext.fetch(req) else {
            return []
        }
        return messages
        
    }
    
    func fetchingMessager(chat: Chat) -> [Message] {
        let message = chat.messages as? Set<Message> ?? []
        return message.sorted {
            ($0.timestamp ?? .distantPast) > ($1.timestamp ?? .distantPast)
        }
    }
    
    func creatMessage(text: String, chat: Chat) {
        
        let message = Message(context: serviceContainer.persistentContainer.viewContext)
        message.id = UUID().uuidString
        message.text = text
        message.timestamp = Date()
        message.chat = chat
        
        serviceContainer.saveContext()
    }

}
