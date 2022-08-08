//
//  UserDetailViewModel.swift
//  VietVkNotes
//
//  Created by VietVk on 08/08/2022.
//

import Combine

struct UserDetailViewModel {
    let navigator: UserDetailNavigatorType
    let useCase: UserDetailUseCaseType
    let user: User
}
extension UserDetailViewModel: ViewModel {
    
    struct Input {
        let loadTrigger: Driver<Void>
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
        
        return output
    }
    
    
}
