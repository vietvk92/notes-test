//
//  MainAssembler.swift
//  VietVkNotes
//
//  Created by VietVk on 06/08/2022.
//

import UIKit

protocol MainAssembler {
    func resolve(navigationController: UINavigationController, user: User) -> MainViewController
    func resolve(navigationController: UINavigationController, user: User) -> MainViewModel
    func resolve(navigationController: UINavigationController) -> MainNavigatorType
    func resolve() -> MainUseCaseType
}

extension MainAssembler {
    func resolve(navigationController: UINavigationController, user: User) -> MainViewController {
        let vc = MainViewController.instantiate()
        let vm: MainViewModel = resolve(navigationController: navigationController, user: user)
        vc.bindViewModel(to: vm)
        return vc
    }
    
    func resolve(navigationController: UINavigationController, user: User) -> MainViewModel {
        return MainViewModel(
            navigator: resolve(navigationController: navigationController),
            useCase: resolve(),
            user: user
        )
    }
}

extension MainAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> MainNavigatorType {
        return MainNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> MainUseCaseType {
        return MainUseCase(noteGateway: resolve())
    }
}

