//
//  Note.swift
//  VietVkNotes
//
//  Created by VietVk on 07/08/2022.
//

import Foundation
import Then

struct Note: Codable, Hashable {
    let title: String
    let content: String
    var createdDate = Date()
    let userId: String

    var formatDate: String {
        get {
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "yyyy-MM-dd"
            return dateFormat.string(from: createdDate)
        }
    }
}

extension Note: Then, Equatable {
    static func == (lhs: Note, rhs: Note) -> Bool {
        return lhs.content == rhs.content
        && lhs.formatDate == rhs.formatDate
    }
}
