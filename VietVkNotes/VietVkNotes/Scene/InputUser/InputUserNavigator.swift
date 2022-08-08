//
//  InputUserNavigator.swift
//  VietVkNotes
//
//  Created by VietVk on 06/08/2022.
//

import UIKit

protocol InputUserNavigatorType {
    func showMain(user: User)
}

struct InputUserNavigator: InputUserNavigatorType, ShowingMain {
    var navigationController: UINavigationController
    let assembler: Assembler
}

