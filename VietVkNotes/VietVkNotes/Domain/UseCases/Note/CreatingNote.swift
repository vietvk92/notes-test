//
//  CreatingNote.swift
//  VietVkNotes
//
//  Created by VietVk on 08/08/2022.
//

import Combine

protocol CreatingNote {
    var createNoteGateway: CreateNoteGatewayType { get }
}

extension CreatingNote {
    func createNoteBy(title: String, content: String) -> Future<Void, Never> {
        createNoteGateway.createNote(title: title, content: content)
    }
}

