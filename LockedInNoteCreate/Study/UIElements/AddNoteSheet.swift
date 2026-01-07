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
    @Binding var existingTags : [Tag]
    
    var onSave: () -> Void
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        NavigationView {
            Form {
                Section(header: Text("Note Title")
                    .font(.custom("Futura Medium", size: 23))
                    .foregroundStyle(.white)) {
                        TextField("Note Name", text: $noteName)
                            .font(.custom("Futura Medium", size: 17))
                            .foregroundStyle(Color.white)
                    }
                    .listRowBackground(Color.gray.opacity(0.3))
                
                Section(header: Text("Existing Tags")
                    .font(.custom("Futura Medium", size: 23))
                    .foregroundStyle(.white)) {
                        let pickerText = existingTags.isEmpty ? "No Existing Tags" : "Choose a Tag"
                        Picker(pickerText, selection: $noteTag) {
                            ForEach($existingTags) { $tag in
                                if !noteTags.contains(tag.name) {
                                    Text(tag.name).tag(tag.name)
                                        
                                }
                            }
                        }
                        .font(.custom("Futura Medium", size: 17))
                        .foregroundStyle(Color.gray)
                        .pickerStyle(.menu)
                }
                    .listRowBackground(Color.gray.opacity(0.3))
                
                Section(header: HStack{
                    Text("Tags")
                        .font(.custom("Futura Medium", size: 23))
                        .foregroundStyle(.white)
                    
                    Spacer()
                    
                    Button(action:{
                        showPopup = true
                    }){
                        Text("+")
                            .font(.custom("Futura Medium", size: 23))
                            .foregroundStyle(.tint)
                            .overlay(RoundedRectangle(cornerRadius:45)
                                .frame(width: 50, height: 35)
                                .foregroundStyle(.white.opacity(0.3)))
                    }
                    .alert("New Tag", isPresented: $showPopup) {
                        TextField("", text: $noteTag)
                            .autocorrectionDisabled()
                        
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
                    
                })
                {
                    List(noteTags, id: \.self) {
                        tag in
                        HStack {
                            Text(tag)
                                .font(.custom("Futura Medium", size: 17))
                                .foregroundStyle(.white)
                            
                            Spacer()
                            
                            Button(action:{
                                noteTags.removeAll(where: { $0 == tag })
                            }) {
                                Image(systemName:"trash")
                                    .foregroundStyle(.red.opacity(0.9))
                            }
                           
                        }
                    }
                }
                .listRowBackground(Color.gray.opacity(0.3))
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("New Note")
                        .font(.custom("Futura Medium", size: 16))
                        .foregroundColor(.white)
                    
                }
            }
            
            .scrollContentBackground(.hidden)
            .background(Color.buttonColour)
            
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action:{
                        dismiss()
                    }) {
                        Text("Cancel")
                            .font(.custom("Futura Medium", size: 16))
                            .foregroundStyle(.tint)
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(action:{
                        onSave()
                        dismiss()
                    }) {
                        Text("Save")
                            .font(.custom("Futura Medium", size: 16))
                            .foregroundStyle(.tint)
                    }
                }
            }
            
        }
    }
}

