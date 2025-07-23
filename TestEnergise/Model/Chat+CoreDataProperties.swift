//
//  Chat+CoreDataProperties.swift
//  TestEnergise
//
//  Created by Andrii Kyrychenko on 19/07/2025.
//
//

import Foundation
import CoreData


extension Chat {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Chat> {
        return NSFetchRequest<Chat>(entityName: "Chat")
    }

    @NSManaged public var dateCreate: Date?
    @NSManaged public var id: String?
    @NSManaged public var messages: NSSet?

}

extension Chat {
    
    @objc(addMessagesObject:)
    @NSManaged public func addToMessages(_ value: Message)
    
    @objc(removeMessagesObject:)
    @NSManaged public func removeFromMessages(_ value: Message)
    
    @objc(addMessages:)
    @NSManaged public func addToMessages(_ value: NSSet)
    
    @objc(removeMessages:)
    @NSManaged public func removeFromMessages(_ value: NSSet)
}

extension Chat : Identifiable {

}
