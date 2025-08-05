//
//  MessageService.swift
//  TestEnergise
//
//  Created by Andrii Kyrychenko on 19/07/2025.
//

import Foundation
import CoreData

final class MessageService: MessageServiceProtocol {
    
    private let serviceContainer: ServiceContainer
    
    init(serviceContainer: ServiceContainer) {
        self.serviceContainer = serviceContainer
    }
    
    func fetchMessages() -> [Message] {
        let req = Message.fetchRequest()
        let context = serviceContainer.viewContext
        guard let messages = try? context.fetch(req) else {
            return []
        }
        return messages
        
    }
    
    func fetchMessages(chat: Chat) -> [Message] {
        
        let context = serviceContainer.viewContext
        let request: NSFetchRequest<Message> = Message.fetchRequest()
        request.predicate = NSPredicate(format: "chat == %@", chat)
        request.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: false)]
        
        return (try? context.fetch(request)) ?? []
    }
    
    func createMessage(text: String, chat: Chat, isUserMessage: Bool) -> Message? {
        
        let context = serviceContainer.viewContext
        let message = Message(context: context)
        message.id = UUID().uuidString
        message.text = text
        message.timestamp = Date()
        message.chat = chat
        message.isFromCurrentUser = isUserMessage
        
        serviceContainer.saveContext()
        
        return message
    }

}
