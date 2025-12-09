//
//  MenuNote.swift
//  LockedInNoteCreate
//
//  Created by Kevin Nhan on 2025-12-08.
//

import SwiftUI

struct MenuNote: View {
    @State private var isEditingNoteName = false
    @State private var warning = false
    
    @Binding var isEditingNoteTags : Bool
    @Binding var notes : [Note]
    @Binding var note: Note
    
    var onEditTags : (() -> Void)?
    
    var body : some View {
        ZStack {
            Menu {
                Button() {
                    isEditingNoteName = true
                } label: {
                    Label("Edit Name", systemImage: "pencil")
                }
                
                Button() {
                    onEditTags?()
                    isEditingNoteTags = true
                } label: {
                    Label("Edit Tags", systemImage: "tag.fill")
                }
                
                Button(role: .destructive) {
                    warning = true
                } label: {
                    Label("Delete", systemImage: "trash")
                }
                
            } label : {
                // RIGHT SIDE BUTTON
                Image(systemName: "ellipsis")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(.gray)
            }
            .alert("Note Name", isPresented: $isEditingNoteName) {
                let previousNoteName = note.title
                
                TextField("", text: $note.title)
                
                Button(role: .cancel) {
                    isEditingNoteName = false
                }
                
                Button(action: {
                    if note.title.isEmpty {
                        note.title = previousNoteName
                    }
                }) {
                    Text("Ok")
                }
            }
            
            .alert("Delete Note", isPresented: $warning) {
                Button(role: .cancel) {
                    warning = false
                }
                
                Button(role: .destructive) {
                    notes.removeAll(where: { $0.id == note.id })
                }
                
            }
        }
        
    }
    
}
