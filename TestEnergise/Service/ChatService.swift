//
//  ChatService.swift
//  TestEnergise
//
//  Created by Andrii Kyrychenko on 19/07/2025.
//

import Foundation
import CoreData

final class ChatService: ChatServiceProtocol {
    
    private let serviceContainer: ServiceContainer
    
    init(serviceContainer: ServiceContainer) {
        self.serviceContainer = serviceContainer
    }
    
    func fetchChats() -> [Chat] {
        let request: NSFetchRequest<Chat> = Chat.fetchRequest()
        let context = serviceContainer.viewContext
        guard let chats = try? context.fetch(request) else {
            return []
        }
        return chats.sorted { $0.dateCreate ?? .distantPast > $1.dateCreate ?? .distantPast }
        
    }
    
    func createChat() -> Chat {
        let context = serviceContainer.viewContext
        let chat = Chat(context: context)
        chat.id = UUID().uuidString
        chat.dateCreate = Date()
        
        serviceContainer.saveContext()
        return chat
    }

    func delete(_ chat: Chat) {
        let context = serviceContainer.viewContext
        context.delete(chat)
        
        serviceContainer.saveContext()
    }
}
