//
//  GenericSubscriber.swift
//  VietVkNotes
//
//  Created by VietVk on 07/08/2022.
//

import Combine

struct GenericSubscriber<Value>: Subscriber {  // swiftlint:disable:this final_class
    var combineIdentifier = CombineIdentifier()
    private let _subscribing: (Value) -> Void
    
    init<Target: AnyObject>(_ target: Target, subscribing: @escaping (Target, Value) -> Void) {
        weak var weakTarget = target
        
        self._subscribing = { value in
            if let target = weakTarget {
                subscribing(target, value)
            }
        }
    }
    
    func receive(subscription: Subscription) {
        subscription.request(.max(1))
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        
    }
    
    func receive(_ input: Value) -> Subscribers.Demand {
        _subscribing(input)
        return .unlimited
    }
}
