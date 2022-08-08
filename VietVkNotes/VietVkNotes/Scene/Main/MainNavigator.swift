//
//  MainNavigator.swift
//  VietVkNotes
//
//  Created by VietVk on 07/08/2022.
//

import UIKit

protocol MainNavigatorType {
    func toUserList()
    func toCreateNote(note: Note?)
}

struct MainNavigator: MainNavigatorType, ShowingCreateNote, ShowingUsers {
    
    let assembler: Assembler
    let navigationController: UINavigationController
    
    func toUserList() {
        showUsers()
    }
    
    func toCreateNote(note: Note?) {
        showCreateNote(note: note)
    }
    
}
