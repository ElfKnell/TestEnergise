//
//  ServiceContainer.swift
//  TestEnergise
//
//  Created by Andrii Kyrychenko on 19/07/2025.
//

import Foundation
import CoreData

class ServiceContainer {
    
    private let persistentContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    lazy var chatService: ChatServiceProtocol = {
        ChatService(serviceContainer: self)
    }()
    
    lazy var messageService: MessageServiceProtocol = {
        MessageService(serviceContainer: self)
    }()
    
    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                print("Error: \(error)")
            }
        }
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
