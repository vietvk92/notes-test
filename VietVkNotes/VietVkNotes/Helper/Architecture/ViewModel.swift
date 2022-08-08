//
//  ViewModel.swift
//  VietVkNotes
//
//  Created by VietVk on 07/08/2022.
//

import Combine

protocol ViewModel {
    associatedtype Input
    associatedtype Output
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output
}

