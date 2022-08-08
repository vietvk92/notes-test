//
//  UserDetailUseCase.swift
//  VietVkNotes
//
//  Created by VietVk on 08/08/2022.
//

import Combine

protocol UserDetailUseCaseType {
    func getNotesByUser(user: User) -> Future<[Note], Never>
}

struct UserDetailUseCase: UserDetailUseCaseType, GettingNotes {
    var noteGateway: NoteGatewayType
    
    func getNotesByUser(user: User) -> Future<[Note], Never> {
        getNotes(user: user)
    }
}
