//
//  InputUserUseCase.swift
//  VietVkNotes
//
//  Created by VietVk on 06/08/2022.
//

import Combine

protocol InputUserUseCaseType {
    func inputUser(dto: InputUserDto) -> Future<User, Never>
}

struct InputUserUseCase: InputUserUseCaseType, InputingUser {
    let authGateway: AuthGatewayType
    
}
