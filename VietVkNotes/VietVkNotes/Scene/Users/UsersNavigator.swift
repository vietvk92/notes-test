//
//  UsersNavigator.swift
//  VietVkNotes
//
//  Created by VietVk on 08/08/2022.
//

import UIKit

protocol UsersNavigatorType {
    func showUserDetail(user: User)
}

struct UsersNavigator: UsersNavigatorType, ShowingUserDetail {
    let assembler: Assembler
    let navigationController: UINavigationController
}
