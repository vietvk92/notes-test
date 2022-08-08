//
//  UserDetailNavigator.swift
//  VietVkNotes
//
//  Created by VietVk on 08/08/2022.
//

import UIKit

protocol UserDetailNavigatorType {

}

struct UserDetailNavigator: UserDetailNavigatorType {
    let assembler: Assembler
    let navigationController: UINavigationController
}
