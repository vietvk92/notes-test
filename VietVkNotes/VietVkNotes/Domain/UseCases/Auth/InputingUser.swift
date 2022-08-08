//
//  Inputing.swift
//  VietVkNotes
//
//  Created by VietVk on 07/08/2022.
//

import Combine
import Foundation
import ValidatedPropertyKit
import Dto

struct InputUserDto: Dto {
    @Validated(.nonEmpty(message: "Please enter username"))
    var username: String?
    
    var validatedProperties: [ValidatedProperty] {
        return [_username]
    }
    
    init(username: String) {
        self.username = username
    }
    
    init() { }
    
    static func validateUserName(_ username: String) -> Result<String, ValidationError> {
        InputUserDto()._username.isValid(value: username)
    }
}

protocol InputingUser {
    var authGateway: AuthGatewayType { get }
}

extension InputingUser {
    func inputUser(dto: InputUserDto) -> Future<User, Never>{
        return authGateway.inputUser(dto: dto)
    }
}
