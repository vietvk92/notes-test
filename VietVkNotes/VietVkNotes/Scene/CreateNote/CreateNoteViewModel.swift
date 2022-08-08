//
//  CreateNoteViewModel.swift
//  VietVkNotes
//
//  Created by VietVk on 07/08/2022.
//

import Combine
import CombineExt
import Defaults

struct CreateNoteViewModel {
    let useCase: CreateNoteUseCaseType
    let note: Note?
}

extension CreateNoteViewModel: ViewModel {
    struct Input {
        let createNoteTrigger: Driver<(String, String)>
    }
    
    final class Output: ObservableObject {
        @Published var isLoading = false
        @Published var alert = AlertMessage()
        @Published var isDismiss = false
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker(false)
        let output = Output()
        
        input.createNoteTrigger
            .flatMap { (title, content) in
                useCase.createNote(title: title, content: content)
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
            }
            .map { true }
            .assign(to: \.isDismiss, on: output)
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
