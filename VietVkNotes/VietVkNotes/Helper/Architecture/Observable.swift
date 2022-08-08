//
//  Observable.swift
//  VietVkNotes
//
//  Created by VietVk on 07/08/2022.
//

import Combine

typealias Observable<T> = AnyPublisher<T, Error>

extension Publisher {
    func asObservable() -> Observable<Output> {
        self
            .mapError { $0 }
            .eraseToAnyPublisher()
    }
    
    static func just(_ output: Output) -> Observable<Output> {
        Just(output)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    static func empty() -> Observable<Output> {
        return Empty().eraseToAnyPublisher()
    }
}
