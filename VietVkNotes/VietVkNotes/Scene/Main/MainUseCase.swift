//
//  MainUseCase.swift
//  VietVkNotes
//
//  Created by VietVk on 07/08/2022.
//

import Combine

protocol MainUseCaseType {
    func getNotesByUser(user: User) -> Future<[Note], Never>
}

struct MainUseCase: MainUseCaseType, GettingNotes {
    var noteGateway: NoteGatewayType

    func getNotesByUser(user: User) -> Future<[Note], Never> {
       getNotes(user: user)
    }
}

