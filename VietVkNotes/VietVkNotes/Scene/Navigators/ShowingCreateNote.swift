//
//  ShowingCreateNote.swift
//  VietVkNotes
//
//  Created by VietVk on 07/08/2022.
//

import UIKit

protocol ShowingCreateNote {
    var assembler: Assembler { get }
}

extension ShowingCreateNote {
    func showCreateNote(note: Note?) {
        if let topVC = UIApplication.getTopViewController() {
            let vc: CreateNoteViewController = assembler.resolve(note: note)
            vc.modalPresentationStyle = .fullScreen
            topVC.present(vc, animated: true)
        }
    }
}
