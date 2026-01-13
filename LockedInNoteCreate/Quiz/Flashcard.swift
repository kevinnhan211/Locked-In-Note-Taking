//
//  Flashcard.swift
//  LockedInNoteCreate
//
//  Created by Kevin Nhan on 2026-01-12.
//

import Foundation

struct Card : Equatable {
    var term : String
    var definition : String
}

struct Flashcard : Identifiable, Equatable {
    let id = UUID()
    
    var title : String
    var description : String = ""
    
    var terms : Int
    var cards : [Card]
}
