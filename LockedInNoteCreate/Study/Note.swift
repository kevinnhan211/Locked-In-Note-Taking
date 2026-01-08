//
//  Note.swift
//  LockedInNoteCreate
//
//  Created by Kevin Nhan on 2025-12-01.
//

import Foundation
import PencilKit

struct Note : Identifiable {
    let id = UUID()
    
    var title : String
    var date : Date
    var tags : [String]
    
    var drawingData: PKDrawing?
    var textData : [UITextView]?
}
