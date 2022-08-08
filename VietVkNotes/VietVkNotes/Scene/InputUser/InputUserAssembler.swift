//
//  InputUserAssembler.swift
//  VietVkNotes
//
//  Created by VietVk on 06/08/2022.
//

import UIKit

protocol InputUserAssembler {
    func resolve(navigationController: UINavigationController) -> InputUserViewController
    func resolve(navigationController: UINavigationController) -> InputUserViewModel
    func resolve(navigationController: UINavigationController) -> InputUserNavigatorType
    func resolve() -> InputUserUseCaseType
}

extension InputUserAssembler {
    func resolve(navigationController: UINavigationController) -> InputUserViewController {
        let vc = InputUserViewController.instantiate()
        let vm: InputUserViewModel = resolve(navigationController: navigationController)
        vc.bindViewModel(to: vm)
        return vc
    }
    
    func resolve(navigationController: UINavigationController) -> InputUserViewModel {
        InputUserViewModel(
            navigator: resolve(navigationController: navigationController),
            useCase: resolve()
        )
    }
}

extension InputUserAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> InputUserNavigatorType {
        InputUserNavigator(navigationController: navigationController, assembler: self)
    }
    
    func resolve() -> InputUserUseCaseType {
        InputUserUseCase(authGateway: resolve())
    }
}
