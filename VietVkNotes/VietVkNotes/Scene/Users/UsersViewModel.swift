//
//  UsersViewModel.swift
//  VietVkNotes
//
//  Created by VietVk on 08/08/2022.
//

import UIKit
import Combine

struct UsersViewModel {
    let navigator: UsersNavigatorType
    let useCase: UsersUseCaseType
}

// MARK: - ViewModelType
extension UsersViewModel: ViewModel {
    struct Input {
        let loadTrigger: Driver<Void>
        let selectTrigger: Driver<IndexPath>
    }
    
    final class Output: ObservableObject {
        @Published var users = [User]()
        @Published var isLoading = false
        @Published var alert = AlertMessage()
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker(false)
        let output = Output()
        
        input.loadTrigger
            .flatMap {
                useCase.getUsers()
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
            }
            .map { $0.filter {!$0.isMe} }
            .assign(to: \.users, on: output)
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
        
        input.selectTrigger
            .sink(receiveValue: { indexPath in
                let user = output.users[indexPath.row]
                self.navigator.showUserDetail(user: user)
            })
            .store(in: cancelBag)
        
        return output
    }
}
