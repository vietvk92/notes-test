//
//  UsersUseCase.swift
//  VietVkNotes
//
//  Created by VietVk on 08/08/2022.
//

import Combine

protocol UsersUseCaseType {
    func getUsers() -> Future<[User], Never>
}

struct UsersUseCase: UsersUseCaseType, GettingUsers {
    
    var userGateway: UserGatewayType

    func getUsers() -> Future<[User], Never> {
        getUsersUseCase()
    }
}

