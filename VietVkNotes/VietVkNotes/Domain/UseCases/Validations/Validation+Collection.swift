//
//  Validation+Collection.swift
//  VietVkNotes
//
//  Created by VietVk on 07/08/2022.
//

import ValidatedPropertyKit

extension Validation where Value: Collection {
    /// The non empty Validation with error message
    static func nonEmpty(message: String) -> Validation {
        return .init { value in
            if !value.isEmpty {
                return .success(())
            } else {
                return .failure(ValidationError(message: message))
            }
        }
    }
}
