//
//  MainViewModel.swift
//  VietVkNotes
//
//  Created by VietVk on 07/08/2022.
//

import Combine
import CombineExt

struct MainViewModel {
    let navigator: MainNavigatorType
    let useCase: MainUseCaseType
    let user: User
}

extension MainViewModel: ViewModel {
    
    struct Input {
        let loadTrigger: Driver<Void>
        let createNoteTrigger: Driver<Void>
        let userListTrigger: Driver<Void>
    }
    
    final class Output: ObservableObject {
        @Published var notes: [Note] = []
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        input.loadTrigger
            .map {self.user}
            .flatMap {
                useCase.getNotesByUser(user: $0)
            }
            .assign(to: \.notes, on: output)
            .store(in: cancelBag)
        
        input.createNoteTrigger.sink { _ in
            self.navigator.toCreateNote(note: nil)
        }
        .store(in: cancelBag)
        
        input.userListTrigger.sink { _ in
            self.navigator.toUserList()        }
        .store(in: cancelBag)
        
        return output
    }
    
    
}
