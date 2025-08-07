//
//  ChatPresenter.swift
//  TestEnergise
//
//  Created by Andrii Kyrychenko on 21/07/2025.
//

import Foundation

class ChatPresenter: ChatPresenterProtocol {
    
    weak var view: ChatViewProtocol?
    
    private(set) var messages: [Message] = []
    
    private let chatService: ChatServiceProtocol
    private let messageService: MessageServiceProtocol
    
    var chat: Chat?
    
    init(chatService: ChatServiceProtocol, messageService: MessageServiceProtocol) {
        self.chatService = chatService
        self.messageService = messageService
    }
    
    func viewDidLoad() {
        
        if let existingChat = chat {
            loadMessages(for: existingChat)
        }
    }
    
    func viewDidDisappear() {
        
        chat = nil
        messages = []
    }
    
    func sendMessage(text: String) {
        
        guard !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return
        }
        if self.chat == nil {
            self.chat = chatService.createChat()
        }
        guard let currentChat = self.chat else {
            view?.showErrorMessage(NSLocalizedString("chat_creation_error", comment: "Error creating chat"))
            return
        }
        
        let userMessage = messageService.createMessage(text: text, chat: currentChat, isUserMessage: true)
        if let userMessage {
            self.messages.append(userMessage)
            view?.appendNewMessage(userMessage)
            view?.clearMessageInput()
            view?.scrollToBottom()
        }
        
        let currentLanguage = Locale.current.region
        
        let answersData = AnswersData()
        var answers = [String]()
        if currentLanguage == "DE" {
            answers = answersData.germanSentences
        } else {
            answers = answersData.sentences
        }
        let randomNumber = Int.random(in: 0..<answers.count)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self else { return }
            guard let currentChat = self.chat else { return }
            let aiMessage = self.messageService.createMessage(text: answers[randomNumber], chat: currentChat, isUserMessage: false)
            if let aiMessage {
                self.messages.append(aiMessage)
                self.view?.appendNewMessage(aiMessage)
                self.view?.scrollToBottom()
            }
        }
        
        
        let messages = messageService.fetchMessages(chat: currentChat)
        
        view?.displayMessages(messages)
    }
    
    private func loadMessages(for chat: Chat) {
        
        view?.showLoadingIndicator()
        
        let fetchedMessages = messageService.fetchMessages(chat: chat)
        messages = fetchedMessages
            .sorted(by: { $0.timestamp ?? Date.distantPast < $1.timestamp ?? Date.distantPast })
        
        view?.hideLoadingIndicator()
        view?.displayMessages(messages)
        view?.scrollToBottom()
    }
}
