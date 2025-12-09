//
//  EditNoteTags.swift
//  LockedInNoteCreate
//
//  Created by Kevin Nhan on 2025-12-08.
//

import SwiftUI

struct EditNoteTags: View {
    @Binding var note: Note
    @Binding var tags : [Tag]
    
    var onSave : () -> Void 
    @Environment(\.dismiss) var dismiss
    
    @State private var newTag: String = ""
    @State private var selectedTag: String? = nil
    
    @State private var showAddTagAlert = false
    
    var body: some View {
        NavigationStack {
            Form {
                // Current Tags Section
                Section(header: Text("Tags")
                    .font(.custom("Futura Medium", size: 23))
                    .foregroundStyle(.white)
                ) {
                    
                    List(note.tags, id: \.self) { tag in
                        HStack {
                            Text(tag)
                                .font(.custom("Futura Medium", size: 16))
                                .foregroundStyle(.white)
                            
                            Spacer()
                            
                            Button {
                                note.tags.removeAll(where: { $0 == tag })
                            } label: {
                                Image(systemName: "trash")
                                    .foregroundStyle(.red)
                            }
                            .buttonStyle(.borderless)
                        }
                        .listRowBackground(Color.gray.opacity(0.3))
                    }
                }
                
                // Add New Tag
                Section(header: HStack{
                    Text("Add Tag")
                        .font(.custom("Futura Medium", size: 23))
                        .foregroundStyle(.white)
                    
                    Spacer()
                    
                    Button(action: {
                        showAddTagAlert = true
                        let trimmed = newTag.trimmingCharacters(in: .whitespaces)
                        if !trimmed.isEmpty && !note.tags.contains(trimmed) {
                            note.tags.append(trimmed)
                            newTag = ""
                        }
                    }) {
                        Text("+")
                            .font(.custom("Futura Medium", size: 23))
                            .foregroundStyle(.tint)
                            .overlay(RoundedRectangle(cornerRadius:45)
                                .frame(width: 50, height: 35)
                                .foregroundStyle(.white.opacity(0.3)))
                    }
                }
                ) {
                    
                }
                
            }
            .alert("Add Tag", isPresented: $showAddTagAlert) {
                TextField("", text: $newTag)
                    .autocorrectionDisabled()
                
                Button(role: .cancel) {
                    newTag = ""
                }
                
                Button(action: {
                    let trimmed = newTag.trimmingCharacters(in: .whitespaces)
                    if !trimmed.isEmpty && !note.tags.contains(trimmed) {
                        note.tags.append(trimmed)
                    }
                    newTag = ""
                }) {
                    Text("Ok")
                }
            }
            
            // Make the form background invisible so your custom color shows
            .scrollContentBackground(.hidden)
            .background(Color.buttonColour)
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("New Tag")
                        .font(.custom("Futura Medium", size: 16))
                        .foregroundColor(.white)
                    
                }
            }

            .toolbar {
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                        .font(.custom("Futura Medium", size: 16))
                        .foregroundStyle(.white)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        onSave()
                        dismiss()
                    }
                        .font(.custom("Futura Medium", size: 16))
                        .foregroundStyle(.white)
                }
            }
        }
    }
}
