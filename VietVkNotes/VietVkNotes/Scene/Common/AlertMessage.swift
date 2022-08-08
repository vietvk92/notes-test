//
//  AlertMessage.swift
//  VietVkNotes
//
//  Created by VietVk on 07/08/2022.
//

import Combine
import Then

struct AlertMessage {
    var title = ""
    var message = ""
    var isShowing = false
    
    init(title: String, message: String, isShowing: Bool) {
        self.title = title
        self.message = message
        self.isShowing = isShowing
    }
    
    init() {
        
    }
}

extension AlertMessage {
    init(error: Error) {
        self.title = "Error"
        let message = error.localizedDescription
        self.message = message
        self.isShowing = !message.isEmpty
    }
}

extension AlertMessage: Then { }
