//
//  UsersAssembler.swift
//  VietVkNotes
//
//  Created by VietVk on 08/08/2022.
//

import UIKit

protocol UsersAssembler {
    func resolve(navigationController: UINavigationController) -> UsersViewController
    func resolve(navigationController: UINavigationController) -> UsersViewModel
    func resolve(navigationController: UINavigationController) -> UsersNavigatorType
    func resolve() -> UsersUseCaseType
}

extension UsersAssembler {
    func resolve(navigationController: UINavigationController) -> UsersViewController {
        let vc = UsersViewController.instantiate()
        let vm: UsersViewModel = resolve(navigationController: navigationController)
        vc.bindViewModel(to: vm)
        return vc
    }
    
    func resolve(navigationController: UINavigationController) -> UsersViewModel {
        return UsersViewModel(
            navigator: resolve(navigationController: navigationController),
            useCase: resolve()
        )
    }
}

extension UsersAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> UsersNavigatorType {
        return UsersNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> UsersUseCaseType {
        return UsersUseCase(userGateway: resolve())
    }
}
