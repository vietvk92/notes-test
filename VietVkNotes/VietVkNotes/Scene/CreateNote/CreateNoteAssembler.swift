//
//  CreateNoteAssembler.swift
//  VietVkNotes
//
//  Created by VietVk on 07/08/2022.
//

import UIKit

protocol CreateNoteAssembler {
    func resolve(note: Note?) -> CreateNoteViewController
    func resolve(note: Note?) -> CreateNoteViewModel
    func resolve() -> CreateNoteUseCaseType
}

extension CreateNoteAssembler {
    func resolve(note: Note?) -> CreateNoteViewController {
        let vc = CreateNoteViewController.instantiate()
        let vm: CreateNoteViewModel = resolve(note: note)
        vc.bindViewModel(to: vm)
        return vc
    }
    
    func resolve(note: Note?) -> CreateNoteViewModel {
        CreateNoteViewModel(useCase: resolve(), note: note)
    }
}

extension CreateNoteAssembler where Self: DefaultAssembler {
    func resolve() -> CreateNoteUseCaseType {
        return CreateNoteUseCase(createNoteGateway: resolve())
    }
}
