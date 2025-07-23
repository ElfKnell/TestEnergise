//
//  ChatViewUpdating.swift
//  TestEnergise
//
//  Created by Andrii Kyrychenko on 21/07/2025.
//

import Foundation

protocol ChatViewUpdating: AnyObject {
    func updateMessage(_ messages: [Message])
}
