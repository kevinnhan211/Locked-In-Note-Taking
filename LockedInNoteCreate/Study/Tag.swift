//
//  Tag.swift
//  LockedInNoteCreate
//
//  Created by Kevin Nhan on 2025-12-01.
//

import Foundation

struct Tag: Identifiable {
    let id = UUID()
    
    var name : String
    var active : Bool = false
}
