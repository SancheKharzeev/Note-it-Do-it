//
//  NotesDelegate.swift
//  Note it Do it
//
//  Created by Александр Х on 17.04.2023.
//

import UIKit

protocol NewNoteDelegate: AnyObject {
  func willSaveNewNote()
  func didClearNewNote()
  func didShareNote()
}

protocol NewNoteDataSource: AnyObject {
  func getNewNoteLength() -> Int
}

protocol NotesDelegate: AnyObject {
    func didSaveNote(note: NoteItem)
    func didEditNote(noteIndexPath: IndexPath, title: String, body: String)
}
