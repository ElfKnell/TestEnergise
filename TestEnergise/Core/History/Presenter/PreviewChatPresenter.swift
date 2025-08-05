//
//  PreviewChatPresenter.swift
//  TestEnergise
//
//  Created by Andrii Kyrychenko on 21/07/2025.
//

import Foundation

class PreviewChatPresenter: PreviewChatPresenterProtocol {
    
    weak var view: PreviewChatViewProtocol?
    //private(set) var messages: [String] = []
    private(set) var messages: [Message] = []
    
    private let chat: Chat
    let messageService: MessageServiceProtocol
    
    init(chat: Chat, messageService: MessageServiceProtocol) {
        self.chat = chat
        self.messageService = messageService
    }
    
    func viewDidLoad() {
        view?.setChatTitle(chat.dateCreate?.formatted() ?? NSLocalizedString("preview_label", comment: "Default chat title"))
        fetchingMessages()
    }
    
    private func fetchingMessages() {
        view?.showLoadingIndicator()
        
        self.messages = messageService.fetchMessages(chat: self.chat)
        
        view?.hideLoadingIndicator()
        view?.displayMessages(self.messages)
    }
}
