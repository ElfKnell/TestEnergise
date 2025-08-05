//
//  HistoryPresenter.swift
//  TestEnergise
//
//  Created by Andrii Kyrychenko on 21/07/2025.
//

import Foundation

class HistoryPresenter: HistoryPresenterProtocol {
    
    weak var view: HistoryViewProtocol?
    
    private(set) var previews: [ChatPreview] = []
    
    private let chatService: ChatServiceProtocol
    let messageService: MessageServiceProtocol
    
    init(chatService: ChatServiceProtocol, messageService: MessageServiceProtocol) {
        self.chatService = chatService
        self.messageService = messageService
    }
    
    func viewDidLoad() {
    }
    
    func viewWillAppear() {
        fetchingChats()
    }
    
    func didSelectChat(at section: Int) {
        guard section < previews.count else {
            view?.showErrorMessage(NSLocalizedString("chat_not_found_error", comment: "Error message for chat not found."))
            return
        }
        let selectedChat = previews[section].chat
        view?.navigateToChatDetail(for: selectedChat)
    }
    
    func didTapDeleteChat(at section: Int) {
        guard section < previews.count else {
            view?.showErrorMessage(NSLocalizedString("chat_not_found_error", comment: "Error message for chat not found."))
            return
        }
        let chatToDelete = previews[section].chat
        chatService.delete(chatToDelete)
        
        previews.remove(at: section)
        view?.deleteSection(IndexSet(integer: section))
    }

    private func fetchingChats() {
        
        view?.showLoadingIndicator()
        let chats = chatService.fetchChats()
        
        self.previews = chats.map { chat in
            let allMessages = messageService.fetchMessages(chat: chat)
            let firstTwo = Array(allMessages.prefix(2))
            return ChatPreview(chat: chat, messages: firstTwo)
        }
        
        view?.hideLoadingIndicator()
        view?.displayChats(self.previews)
    }

}
