//
//  UIViewController+Alert.swift
//  VietVkNotes
//
//  Created by VietVk on 07/08/2022.
//

import UIKit

extension UIViewController {
    func showAlert(_ alert: AlertMessage, completion: (() -> Void)? = nil) {
        let ac = UIAlertController(title: alert.title,
                                   message: alert.message,
                                   preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in
            completion?()
        }
        ac.addAction(okAction)
        present(ac, animated: true, completion: nil)
    }
    
    func showError(_ error: Error, completion: (() -> Void)? = nil) {
        let ac = UIAlertController(title: "Error",
                                   message: error.localizedDescription,
                                   preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in
            completion?()
        }
        ac.addAction(okAction)
        present(ac, animated: true, completion: nil)
    }
}
