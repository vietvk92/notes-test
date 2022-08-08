//
//  InputViewModel.swift
//  VietVkNotes
//
//  Created by VietVk on 06/08/2022.
//

import Combine
import CombineExt
import Defaults

struct InputUserViewModel {
    let navigator: InputUserNavigatorType
    let useCase: InputUserUseCaseType
}

extension InputUserViewModel: ViewModel {
    final class Input: ObservableObject {
        let inputUserTrigger: Driver<String>
        init(inputUserTrigger: Driver<String>) {
            self.inputUserTrigger = inputUserTrigger
        }
    }
    
    final class Output: ObservableObject {
        @Published var isLoading = false
        @Published var alert = AlertMessage()
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker(false)
        let output = Output()
        
        input.inputUserTrigger
            .flatMap { value in
                useCase.inputUser(dto: InputUserDto(username: value))
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
            }
            .sink { value in
                // Storage the user info to local
                Defaults[.user] = value
                self.navigator.showMain(user: value)
            }
            .store(in: cancelBag)
        
        errorTracker
            .receive(on: RunLoop.main)
            .map { AlertMessage(error: $0) }
            .assign(to: \.alert, on: output)
            .store(in: cancelBag)
        
        activityTracker
            .receive(on: RunLoop.main)
            .assign(to: \.isLoading, on: output)
            .store(in: cancelBag)
        
        return output
    }
    
}


