//
//  ChatService.swift
//  TestEnergise
//
//  Created by Andrii Kyrychenko on 19/07/2025.
//

import Foundation
import CoreData

class ChatService {
    
    let serviceContainer: ServiceContainer
    
    init() {
        self.serviceContainer = ServiceContainer.shared
    }
    
    func fetchingChats() -> [Chat] {
        let req = Chat.fetchRequest()
        guard let chats = try? serviceContainer.persistentContainer.viewContext.fetch(req) else {
            return []
        }
        return chats.sorted { $0.dateCreate ?? .distantPast > $1.dateCreate ?? .distantPast }
        
    }
    
    func creatChat() -> Chat {
        let chat = Chat(context: serviceContainer.persistentContainer.viewContext)
        chat.id = UUID().uuidString
        chat.dateCreate = Date()
        
        serviceContainer.saveContext()
        return chat
    }

    func delete(_ chat: Chat) {
        let context = serviceContainer.persistentContainer.viewContext
        context.delete(chat)
        
        serviceContainer.saveContext()
    }
}
