//
//  TableViewSection.swift
//  Notes
//
//  Created by Viki on 14/01/2024.
//

import Foundation

protocol TableViewItemProtocol { }

struct TableViewSection {
    var title: String?
    var items: [TableViewItemProtocol]
}
