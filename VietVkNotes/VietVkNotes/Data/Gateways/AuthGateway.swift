//
//  AuthGateway.swift
//  VietVkNotes
//
//  Created by VietVk on 07/08/2022.
//

import Foundation
import Combine

protocol AuthGatewayType {
    func inputUser(dto: InputUserDto) -> Future<User, Never>
}

struct AuthGateway: AuthGatewayType {
    func inputUser(dto: InputUserDto) -> Future<User, Never> {
        FireBaseService.share.addUser(input: dto)
    }
}
