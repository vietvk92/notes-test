//
//  Bindable.swift
//  VietVkNotes
//
//  Created by VietVk on 07/08/2022.
//

import UIKit

protocol Bindable: AnyObject {
    associatedtype ViewModelType
    var viewModel: ViewModelType! { get set }
    func bindViewModel()
}

extension Bindable where Self: UIViewController {
    func bindViewModel(to model: Self.ViewModelType) {
        viewModel = model
        loadViewIfNeeded()
        bindViewModel()
    }
}
