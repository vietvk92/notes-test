//
//  CreateNoteGateway.swift
//  VietVkNotes
//
//  Created by VietVk on 07/08/2022.
//

import Foundation
import Combine

protocol CreateNoteGatewayType {
    func createNote(title: String, content: String) -> Future<Void, Never>
}

struct CreateNoteGateway: CreateNoteGatewayType {
    func createNote(title: String, content: String) -> Future<Void, Never> {
        FireBaseService.share.addNote(title: title, content: content)
    }
}
