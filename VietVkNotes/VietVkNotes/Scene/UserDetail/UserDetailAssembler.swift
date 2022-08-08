//
//  UserDetailAssembler.swift
//  VietVkNotes
//
//  Created by VietVk on 08/08/2022.
//

import UIKit

protocol UserDetailAssembler {
    func resolve(navigationController: UINavigationController, user: User) -> UserDetailViewController
    func resolve(navigationController: UINavigationController, user: User) -> UserDetailViewModel
    func resolve(navigationController: UINavigationController) -> UserDetailNavigatorType
    func resolve() -> UserDetailUseCaseType
}

extension UserDetailAssembler {
    func resolve(navigationController: UINavigationController, user: User) -> UserDetailViewController {
        let vc = UserDetailViewController.instantiate()
        let vm: UserDetailViewModel = resolve(navigationController: navigationController, user: user)
        vc.bindViewModel(to: vm)
        return vc
    }
    
    func resolve(navigationController: UINavigationController, user: User) -> UserDetailViewModel {
        UserDetailViewModel(
            navigator: resolve(navigationController: navigationController),
            useCase: resolve(),
            user: user
        )
    }
}

extension UserDetailAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> UserDetailNavigatorType {
        UserDetailNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> UserDetailUseCaseType {
        UserDetailUseCase(noteGateway: resolve())
    }
}
