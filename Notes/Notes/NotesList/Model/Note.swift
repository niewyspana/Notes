//
//  Note.swift
//  Notes
//
//  Created by Viki on 14/01/2024.
//

import Foundation

struct Note: TableViewItemProtocol {
    let title: String
    let description: String
    let date: Date
    let imageUrl: String?
    let image: Data?
}
