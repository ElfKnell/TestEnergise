//
//  ChatPresenter.swift
//  TestEnergise
//
//  Created by Andrii Kyrychenko on 21/07/2025.
//

import Foundation

class ChatPresenter {
    
    weak var view: ChatViewUpdating?
    
    let chatService: ChatService
    let messageService: MessageService
    
    var chat: Chat?
    
    let sentences = [
        "Hello there!",
        "How are you?",
        "Nice to meet you.",
        "What's your name?",
        "Let's get started.",
        "I love coding.",
        "Swift is awesome!",
        "It's a sunny day.",
        "Time for a break.",
        "Have a great day!",
        "That was fun.",
        "Try again later.",
        "I’m feeling good.",
        "Welcome back!",
        "Can you help me?",
        "Let's go now.",
        "This is exciting!",
        "I made a mistake.",
        "Everything is fine.",
        "See you soon!"
    ]
    
    let germanSentences = [
        "Hallo da!",
        "Wie geht’s dir?",
        "Schön, dich kennenzulernen.",
        "Wie heißt du?",
        "Lass uns anfangen.",
        "Ich liebe Programmieren.",
        "Swift ist großartig!",
        "Es ist ein sonniger Tag.",
        "Zeit für eine Pause.",
        "Hab einen schönen Tag!",
        "Das hat Spaß gemacht.",
        "Versuche es später noch einmal.",
        "Ich fühle mich gut.",
        "Willkommen zurück!",
        "Kannst du mir helfen?",
        "Lass uns jetzt gehen.",
        "Das ist spannend!",
        "Ich habe einen Fehler gemacht.",
        "Alles ist in Ordnung.",
        "Bis bald!"
    ]
    
    init(chatService: ChatService, messageService: MessageService) {
        self.chatService = chatService
        self.messageService = messageService
    }
    
    func createMessage(text: String) {
        
        let currentLanguage = Locale.current.region
        let randomNumber = Int.random(in: 0...19)
        var answers = [String]()
        if currentLanguage == "DE" {
            answers = germanSentences
        } else {
            answers = sentences
        }
        
        if self.chat == nil {
            self.chat = chatService.creatChat()
        }
        
        guard let chat = self.chat else { return }
        
        messageService.creatMessage(text: text, chat: chat)
        
        messageService.creatMessage(text: answers[randomNumber], chat: chat)
        
        let messages = messageService.fetchingMessager(chat: chat)
        
        view?.updateMessage(messages)
    }
}
