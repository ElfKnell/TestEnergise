//
//  Message+CoreDataProperties.swift
//  TestEnergise
//
//  Created by Andrii Kyrychenko on 19/07/2025.
//
//

import Foundation
import CoreData


extension Message {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Message> {
        return NSFetchRequest<Message>(entityName: "Message")
    }

    @NSManaged public var text: String?
    @NSManaged public var id: String?
    @NSManaged public var timestamp: Date?
    @NSManaged public var chat: Chat?

}

extension Message : Identifiable {

}
