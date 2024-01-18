//
//  Note.swift
//  Notes
//
//  Created by Viki on 14/01/2024.
//

import UIKit

enum NoteCategory: String {
    case personal = "Personal"
    case work = "Work"
    case study = "Study"
    case others = "Others"
    
    var color: UIColor {
        switch self {
        case .personal:
            return UIColor.blue
        case .work:
            return UIColor.green
        case .study:
            return UIColor.orange
        case .others:
            return UIColor.purple
        }
    }
}

struct Note: TableViewItemProtocol {
    let title: String
    let description: String
    let date: Date
    let imageUrl: String?
    let category: NoteCategory
    let image: Data?
    
    var categoryColor: UIColor {
        return category.color
    }
}
