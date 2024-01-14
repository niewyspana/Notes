//
//  NotesListViewModel.swift
//  Notes
//
//  Created by Viki on 14/01/2024.
//

import Foundation

protocol NotesListViewModelProtocol {
    var section: [TableViewSection] { get }
}

final class NotesListViewModel: NotesListViewModelProtocol {
    private(set) var section: [TableViewSection] = []
    
    init() {
        getNotes()
        setMocks()
    }
    
    private func getNotes()  {
        
    }
    
    private func setMocks() {
        let section = TableViewSection(title: "23 Apr 2023", items: [
            Note(title: "First title note", description: "First note description", date: Date(), imageUrl: nil, image: nil),
            Note(title: "Second title note", description: "Second note description", date: Date(), imageUrl: nil, image: nil)
        ])
        self.section = [section]
    }
}
