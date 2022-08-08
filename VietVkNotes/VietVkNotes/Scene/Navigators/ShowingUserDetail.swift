//
//  ShowingUserDetail.swift
//  VietVkNotes
//
//  Created by VietVk on 08/08/2022.
//

import UIKit

protocol ShowingUserDetail {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingUserDetail {
    func showUserDetail(user: User) {
        let vc: UserDetailViewController = assembler.resolve(navigationController: navigationController, user: user)
        navigationController.pushViewController(vc, animated: true)
    }
}
