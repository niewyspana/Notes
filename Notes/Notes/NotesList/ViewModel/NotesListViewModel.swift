//
//  NotesListViewModel.swift
//  Notes
//
//  Created by Viki on 14/01/2024.
//

import Foundation
import UIKit

protocol NotesListViewModelProtocol {
    var section: [TableViewSection] { get }
    var reloadTable: (() -> Void)? { get set }
    
    func getNotes()
    func getImage(for url: URL) -> UIImage?
}

final class NotesListViewModel: NotesListViewModelProtocol {
    var reloadTable: (() -> Void)?
    
    private(set) var section: [TableViewSection] = [] {
    didSet {
        reloadTable?()
    }
}
    
    init() {
        getNotes()
    }
    
    func getNotes()  {
       let notes = NotePersistent.fetchAll()
       section = []
        
        let groupedObjects = notes.reduce(into: [Date: [Note]]()) { result, note in
            let date = Calendar.current.startOfDay(for: note.date)
            result[date, default: []].append(note)
        }
        
        let keys = groupedObjects.keys
        
        keys.forEach { key in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d MMM yyyy"
            let stringDate = dateFormatter.string(from: key)
            
            section.append(TableViewSection(title: stringDate, items: groupedObjects[key] ?? []))
        }
    }
    
    func getImage(for url: URL) -> UIImage?  {
        FileManagerPersistent.read(from: url)
    }
    
    private func setMocks() {
        let section = TableViewSection(title: "23 Apr 2023", items: [
            Note(title: "First title note", description: "First note description", date: Date(), imageURL: nil, category: .personal),
            Note(title: "Second title note", description: "Second note description", date: Date(), imageURL: nil, category: .personal)
        ])
        self.section = [section]
    }
}
