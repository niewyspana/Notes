//
//  NoteViewModel.swift
//  Notes
//
//  Created by Viki on 18/01/2024.
//

import Foundation

protocol NoteViewModelProtocol {
    var text: String { get }
    var hasChanges: Bool { get }
    var isNewNote: Bool { get }
    
    func save(with text: String)
    func delete()
}

final class NoteViewModel: NoteViewModelProtocol {
    let note: Note?
    private var initialText: String?
    var text: String {
        let text = (note?.title ?? "") + "\n\n" + (note?.description?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "")
        return text.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var hasChanges: Bool {
        return text != initialText
    }
    
    var isNewNote: Bool {
        return note == nil
    }

    init(note: Note?) {
        self.note = note
        self.initialText = text
    }
    
    // MARK: - Methods
    func save(with text: String) {
        let date = note?.date ?? Date()
        let (title, description) = createTitleAndDescription(from: text)
        
        let note = Note(title: title,
                        description: description,
                        date: date,
                        imageURL: nil,
                        category: .personal)
        NotePersistent.save(note)
    }
    
    func delete() {
        guard let note = note else {
            return
        }
        NotePersistent.delete(note)
    }
    
    // MARK: - Private methods
    private func createTitleAndDescription(from text: String) -> (String, String?) {
        var description = text
        
        guard let index = description.firstIndex(where: { $0 == "." || $0 == "?" || $0 == "\n" }) else {
            return (text, nil)
        }
        
        let title = String(description[...index])
        description.removeSubrange(...index)
        
        return (title, description)
    }
}
