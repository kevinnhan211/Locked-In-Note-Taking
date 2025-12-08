//
//  StudyView.swift
//  LockedInNoteCreate
//
//  Created by Kevin Nhan on 2025-11-19.
//

import SwiftUI

struct StudyView: View {
    @State private var notes : [Note] = []
    @State private var search : String = ""
    
    @State private var tags : [Tag] = []
    
    // State vars for adding notes
    @State private var showAddNoteSheet = false
    @State private var noteName = "Untitled Note"
    @State private var noteTags : [String] = []
    
    // State vars for active tags
    @State private var activeTags : [String] = []
    
    // State vars for editing notes
    @State private var isEditingNoteName = false
    @State private var isEditingNoteTags = false
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.gradientTop, .gradientBottom], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            // Decorative background image
            Image("bubbleBG")
                .resizable()
                .scaledToFit()
                .opacity(0.25)
            
            VStack {
                HStack {
                    Text("Your Notes")
                        .font(.custom("Futura Medium", size: 30))
                        .bold()
                        .foregroundStyle(.white)
                        .offset(x:18,y:2)
                    
                    Spacer()
                    
                    Button(action:{
                        showAddNoteSheet = true
                    }) {
                        ZStack{
                            RoundedRectangle(cornerRadius: 25)
                                .frame(width:65,height:45)
                                .foregroundStyle(Color.buttonColour)
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 20,height: 20)
                                .foregroundStyle(.white)
                        }
                    }
                    .offset(x:-15)
                    .sheet(isPresented: $showAddNoteSheet) {
                        AddNoteSheet(
                            noteName: $noteName,
                            noteTags: $noteTags,
                            onSave: {
                                // Add Note
                                if !noteName.isEmpty {
                                    notes.append(
                                        Note(title: noteName, date: .now, tags: noteTags)
                                    )
                                    
                                    var newTags : [String] = []
                                    var tagExists : Bool = false
                                    for noteTag in noteTags {
                                        for existingTag in tags {
                                            if noteTag.isEmpty || noteTag == existingTag.name {
                                                tagExists = true
                                            }
                                        }
                                        
                                        if tagExists {
                                            tagExists = false
                                        } else {
                                            newTags.append(noteTag)
                                        }
                                    }
                                    
                                    for newTag in newTags {
                                        tags.append(
                                            Tag(name:newTag)
                                        )
                                    }
                                }
                                
                                // Reset for next time
                                noteName = "Untitled Note"
                                noteTags = []
                            }
                        )
                    }
                    
                }
                .offset(y:10)
                
                Text("Tags")
                    .font(.custom("Futura Medium", size: 23))
                    .foregroundStyle(.white)
                    .padding(.top,30)
                    .padding(.trailing,270)
                
                ScrollView {
                    LazyVGrid(
                        columns: [
                            GridItem(.adaptive(minimum: 80), spacing: 8)
                        ],
                        spacing: 8
                    ) {
                        ForEach($tags) {
                            $tag in
                            TagButton(tag : $tag, activeTags: $activeTags)
                        }
                    }
                    .padding()
                }
                .frame(width: 350, height: 120)   // your size
                .background(Color.buttonColour)
                .cornerRadius(12)
                
                
                TextField(text: $search) {
                    Text("Search")
                        .font(Font.custom("Futura Medium", size: 15))
                        .foregroundStyle(.gray)
                }
                .padding(.leading, 35)     // space for magnifying glass
                .padding(.trailing, 35)    // space for mic
                .frame(width: 350, height: 40)
                .font(.custom("Futura Medium", size: 15))
                .foregroundStyle(Color.white)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundStyle(.buttonColour)
                )
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white)
                            .padding(.leading, 8)
                        
                        Spacer()
                        
                        Image(systemName: "mic.fill")
                            .foregroundColor(.gray)
                            .padding(.trailing, 8)
                    }
                )
                .autocorrectionDisabled()
                .padding()
                
                ScrollView {
                    ForEach(notes.filter { note in
                        
                        // TAG FILTER (always applies)
                        let matchesTags =
                            activeTags.isEmpty ||
                            activeTags.allSatisfy { tag in note.tags.contains(tag) }
                        
                        // SEARCH FILTER (always applies)
                        let matchesSearch =
                            search.isEmpty ||
                            note.title.localizedCaseInsensitiveContains(search)
                        
                        return matchesTags && matchesSearch
                        
                    }) { note in
                        ZStack {
                            NoteButton(
                                name: note.title,
                                dateString: note.date,
                                action: {},
                            )
                            
                            let index = notes.firstIndex(where: { $0.id == note.id })!
                            MenuNote(notes: $notes, note: $notes[index])
                                .offset(x:150)
                            
                        }

                    }
                }

                Spacer()
            }
            
            
        }
        
    }
}

#Preview {
    StudyView()
}
