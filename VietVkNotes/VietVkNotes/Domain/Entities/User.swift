//
//  User.swift
//  VietVkNotes
//
//  Created by VietVk on 07/08/2022.
//

import Then
import Defaults

struct User: Codable, DefaultsSerializable {
    let id: String
    let userName: String
    var isMe: Bool {
        guard let user = Defaults[.user] else {
            return false
        }
        return id == user.id
    }
}

extension User: Then, Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.userName == rhs.userName
    }
}


extension Defaults.Keys {
    static let user = Key<User?>("UserInfoStorage")
}
