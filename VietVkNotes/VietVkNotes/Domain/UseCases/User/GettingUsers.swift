//
//  GettingUsers.swift
//  VietVkNotes
//
//  Created by VietVk on 08/08/2022.
//

import Combine

protocol GettingUsers {
    var userGateway: UserGatewayType { get }
}

extension GettingUsers {
    func getUsersUseCase() -> Future<[User], Never> {
        userGateway.getUsers()
    }
}
