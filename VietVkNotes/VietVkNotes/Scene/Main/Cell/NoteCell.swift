//
//  NoteCell.swift
//  VietVkNotes
//
//  Created by VietVk on 08/08/2022.
//

import UIKit
import Reusable

class NoteCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func bindViewModel(_ item: Note) {
        titleLabel.text = item.title
        contentLabel.text = item.content
        dateLabel.text = item.formatDate
    }
    
}
