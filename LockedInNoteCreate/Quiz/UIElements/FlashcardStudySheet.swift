//
//  FlashcardStudySheet.swift
//  LockedInNoteCreate
//
//  Created by Kevin Nhan on 2026-01-12.
//

import SwiftUI

struct FlashcardStudySheet: View {
    @Binding var flashcard: Flashcard
    
    var onSave: () -> Void
    @Environment(\.dismiss) var dismiss
    
    private func deleteCard(at index: Int) {
        guard flashcard.cards.indices.contains(index) else { return }
        flashcard.cards.remove(at: index)
    }
    
    var body: some View {
        NavigationView {
            Form {
                // MARK: edit title
                Section(header: Text("Title")
                    .font(.custom("Futura Medium", size: 23))
                    .foregroundStyle(.white)
                    .padding(.bottom,5)
                    .padding(.top,15)
                ) {
                    VStack(spacing:25) {
                        TextField("Title", text: $flashcard.title)
                    }
                    .font(.custom("Futura Medium", size: 17))
                    .foregroundStyle(Color.white)
                }
                .listRowBackground(Color.gray.opacity(0.3))
                
                // MARK: edit description
                Section(header: Text("Description")
                    .font(.custom("Futura Medium", size: 23))
                    .foregroundStyle(.white)
                    .padding(.bottom,5)
                    .padding(.top,10)
                ) {
                    VStack(spacing:25) {
                        TextField("Description", text: $flashcard.description)
                    }
                    .font(.custom("Futura Medium", size: 17))
                    .foregroundStyle(Color.white)
                }
                .listRowBackground(Color.gray.opacity(0.3))
                
                // MARK: Add cards
                Section(header: Text("Cards")
                    .font(.custom("Futura Medium", size: 23))
                    .foregroundStyle(.white)
                    .padding(.bottom,5)
                    .padding(.top,10)
                ) {
                    VStack(spacing:25) {
                        // MARK: list of cards
                        ScrollView {
                            ForEach(flashcard.cards.indices, id: \.self) { index in
                                let card = flashcard.cards[index]
                                
                                VStack {
                                    HStack {
                                        Text("\(index+1)")
                                            .bold()
                                        
                                        Spacer()
                                        
                                        // MARK: Delete card
                                        Button {
                                            deleteCard(at: index)
                                        } label: {
                                            Image(systemName: "trash")
                                        }
                                    }
                                    .font(.custom("Futura Medium", size: 16))
                                    .foregroundColor(.white)
                                    
                                    HStack {
                                        TextField("Term", text: $flashcard.cards[index].term)
                                        Spacer()
                                        TextField("Definition", text: $flashcard.cards[index].definition)
                                    }
                                    .font(.custom("Futura Medium", size: 16))
                                    .foregroundColor(.white)
                                }
                                .padding(.bottom, 8)
                                
                            }
                            
                            // MARK: Add card button
                            Button {
                                flashcard.cards.append(
                                    Card(term: "", definition: "")
                                )
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius:12)
                                        .frame(width:150,height:55)
                                        .foregroundStyle(.gradientTop)
                                    
                                    HStack {
                                        Text("Add Card")
                                        Image(systemName: "plus")
                                            .bold()
                                    }
                                    .font(.custom("Futura Medium", size: 17))
                                    .foregroundStyle(.white)
                                }
                            }
                            .padding(.top,20)
                            .padding(.leading,90)
                        }
                        
                    }
                }
                .listRowBackground(Color.gray.opacity(0.3))
                
            }
            .scrollContentBackground(.hidden)
            .background(Color.buttonColour)
            
            .navigationBarTitleDisplayMode(.inline)
            
            // MARK: Middle title context
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Editing Flashcard")
                        .font(.custom("Futura Medium", size: 16))
                        .foregroundColor(.white)
                    
                }
            }
            
            // MARK: Exit button
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action:{
                        dismiss()
                    }) {
                        Text("Exit")
                            .font(.custom("Futura Medium", size: 16))
                            .foregroundStyle(.tint)
                    }
                }
            }
            
            // MARK: Save button
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        onSave()
                        dismiss()
                    } label: {
                        Text("Save")
                            .font(.custom("Futura Medium", size: 16))
                            .foregroundStyle(.tint)
                    }
                }
            }
            
        }
        
    }
    
}
