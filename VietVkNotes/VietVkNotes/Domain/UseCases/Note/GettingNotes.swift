//
//  GettingNotes.swift
//  VietVkNotes
//
//  Created by VietVk on 07/08/2022.
//

import Combine

protocol GettingNotes {
    var noteGateway: NoteGatewayType { get }
}

extension GettingNotes {
    func getNotes(user: User) -> Future<[Note], Never> {
        noteGateway.getNotes(user: user)
    }
}

