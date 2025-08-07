//
//  PreviewChatPresenterProtocol.swift
//  TestEnergise
//
//  Created by Andrii Kyrychenko on 02/08/2025.
//

import Foundation

protocol PreviewChatPresenterProtocol: AnyObject {
        
    var view: PreviewChatViewProtocol? { get set }
    var messages: [Message] { get }
        
    func viewDidLoad()
}
