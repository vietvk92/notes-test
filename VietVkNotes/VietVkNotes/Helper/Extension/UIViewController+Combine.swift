//
//  UIViewController+Combine.swift
//  VietVkNotes
//
//  Created by VietVk on 07/08/2022.
//

import UIKit
import Combine
import MBProgressHUD

extension UIViewController {
    var alertSubscriber: GenericSubscriber<AlertMessage> {
        GenericSubscriber(self) { (vc, alertMessage) in
            vc.showAlert(alertMessage)
        }
    }
    
    var loadingSubscriber: GenericSubscriber<Bool> {
        GenericSubscriber(self) { (vc, isLoading) in
            if isLoading {
                let hud = MBProgressHUD.showAdded(to: vc.view, animated: true)
                hud.offset.y = -30
            } else {
                MBProgressHUD.hide(for: vc.view, animated: true)
            }
        }
    }
    
    var dismissSubscriber: GenericSubscriber<Bool> {
        GenericSubscriber(self) { vc, _  in
            vc.dismiss(animated: true)
        }
    }
}

