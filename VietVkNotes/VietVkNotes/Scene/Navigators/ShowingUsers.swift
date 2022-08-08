//
//  ShowingUsers.swift
//  VietVkNotes
//
//  Created by VietVk on 08/08/2022.
//

import UIKit

protocol ShowingUsers {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingUsers {
    func showUsers() {
        let vc: UsersViewController = assembler.resolve(navigationController: navigationController)
        vc.title = "User List"
        navigationController.pushViewController(vc, animated: true)
    }
}
