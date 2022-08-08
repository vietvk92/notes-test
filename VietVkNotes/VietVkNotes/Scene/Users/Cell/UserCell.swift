//
//  UserCell.swift
//  VietVkNotes
//
//  Created by VietVk on 08/08/2022.
//

import UIKit
import Reusable

class UserCell: UITableViewCell, NibReusable {

    @IBOutlet weak var userLabel: UILabel!
    
    func bindViewModel(_ item: User) {
        userLabel.text = item.userName
    }
    
}
