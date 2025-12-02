//
//  AddNoteSheet.swift
//  LockedInNoteCreate
//
//  Created by Kevin Nhan on 2025-12-01.
//

import SwiftUI

struct AddNoteSheet: View {
    @State private var noteTag : String = ""
    @State private var showPopup : Bool = false
    
    @Binding var noteName: String
    @Binding var noteTags: [String]

    var onSave: () -> Void
    @Environment(\.dismiss) var dismiss

    var body: some View {
        
        NavigationView {
            Form {
                Section(header: Text("Note Title")) {
                    TextField("Note Name", text: $noteName)
                }
                
                Section(header: HStack{
                    Text("Tags")
                    Spacer()
                    
                    Button(action:{
                        showPopup = true
                    }){
                        Text("Add")
                    }
                    .alert("New Tag", isPresented: $showPopup) {
                        TextField("", text: $noteTag)
                        
                        Button(role: .cancel) {
                            noteTag = ""
                        }
                        
                        Button(action: {
                            if noteTag.isEmpty { return }
                            
                            for existingTag in noteTags {
                                if existingTag == noteTag {
                                    noteTag = ""
                                    return
                                }
                            }
                            
                            noteTags.append(noteTag)
                            noteTag = ""
                        }) {
                            Text("Ok")
                        }
                    }
                    
                }) {
                    List(noteTags, id: \.self) {
                        tag in
                        Text(tag)
                    }
                }
                
            }
            .navigationTitle("New Note")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onSave()
                        dismiss()
                    }
                }
            }
        }
    }
}

