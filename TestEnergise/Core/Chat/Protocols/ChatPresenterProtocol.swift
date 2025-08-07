//
//  ChatPresenterProtocol.swift
//  TestEnergise
//
//  Created by Andrii Kyrychenko on 03/08/2025.
//

import Foundation

protocol ChatPresenterProtocol: AnyObject {
    
    var view: ChatViewProtocol? { get set }
    var chat: Chat? { get set }
    var messages: [Message] { get }
    
    func viewDidLoad()
    func viewDidDisappear()
    func sendMessage(text: String)
    
}
