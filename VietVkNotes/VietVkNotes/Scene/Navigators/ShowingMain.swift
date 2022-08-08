//
//  ShowingMain.swift
//  VietVkNotes
//
//  Created by VietVk on 06/08/2022.
//

import UIKit
import SwiftUI

protocol ShowingMain {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingMain {
    func showMain(user: User) {
//        let vc: MainViewController = assembler.resolve(navigationController: UINavigationController(), user: user)
//        let navigationController = UINavigationController(rootViewController: vc)
        
        let nav = UINavigationController()
        let vc: MainViewController = assembler.resolve(navigationController: nav, user: user)
        nav.viewControllers = [vc]
        nav.view.backgroundColor = .white
        UIApplication.shared.keyWindow?.rootViewController = nav
        UIApplication.shared.keyWindow?.makeKeyAndVisible()
    }
}
