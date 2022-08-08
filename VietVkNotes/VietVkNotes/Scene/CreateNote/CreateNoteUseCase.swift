//
//  CreateNoteUseCase.swift
//  VietVkNotes
//
//  Created by VietVk on 07/08/2022.
//

import Foundation
import Combine

protocol CreateNoteUseCaseType {
    func createNote(title: String, content: String) -> Future<Void, Never>
}

struct CreateNoteUseCase: CreateNoteUseCaseType, CreatingNote {
    var createNoteGateway: CreateNoteGatewayType
    
    func createNote(title: String, content: String) -> Future<Void, Never> {
        createNoteBy(title: title, content: content)
    }
}

