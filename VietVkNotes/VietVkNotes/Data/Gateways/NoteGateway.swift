//
//  NoteGateway.swift
//  VietVkNotes
//
//  Created by VietVk on 07/08/2022.
//

import Foundation
import Combine

protocol NoteGatewayType {
    func getNotes(user: User) -> Future<[Note], Never>
}

struct NoteGateway: NoteGatewayType {
    func getNotes(user: User) -> Future<[Note], Never> {
        FireBaseService.share.getNotesBy(user: user)
    }
}
