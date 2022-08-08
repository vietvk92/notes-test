//
//  Driver.swift
//  VietVkNotes
//
//  Created by VietVk on 07/08/2022.
//

import Combine
import Foundation

typealias Driver<T> = AnyPublisher<T, Never>

extension Publisher {
    func asDriver() -> Driver<Output> {
        return self.catch { _ in Empty() }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    static func just(_ output: Output) -> Driver<Output> {
        return Just(output).eraseToAnyPublisher()
    }
    
    static func empty() -> Driver<Output> {
        return Empty().eraseToAnyPublisher()
    }
}
