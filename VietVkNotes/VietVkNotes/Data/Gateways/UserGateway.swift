//
//  UserGateway.swift
//  VietVkNotes
//
//  Created by VietVk on 08/08/2022.
//

import Foundation
import Combine

protocol UserGatewayType {
    func getUsers() -> Future<[User], Never>
}

struct UserGateway: UserGatewayType, NoteGatewayType {
    func getUsers() -> Future<[User], Never> {
        FireBaseService.share.getUsers()
    }
    
    func getNotes(user: User) -> Future<[Note], Never> {
        FireBaseService.share.getNotesBy(user: user)
    }
}

