//
//  ErrorTracker.swift
//  VietVkNotes
//
//  Created by VietVk on 07/08/2022.
//

import Combine

typealias ErrorTracker = PassthroughSubject<Error, Never>

extension Publisher where Failure: Error {
    func trackError(_ errorTracker: ErrorTracker) -> AnyPublisher<Output, Failure> {
        return handleEvents(receiveCompletion: { completion in
            if case let .failure(error) = completion {
                errorTracker.send(error)
            }
        })
        .eraseToAnyPublisher()
    }
}
