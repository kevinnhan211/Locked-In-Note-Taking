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
                        ZStack(alignment:.leading) {
                            if flashcard.title.isEmpty {
                                Text("Enter title")
                                    .foregroundStyle(.gray)
                            }
                            TextField("", text: $flashcard.title)
                        }
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
                        ZStack(alignment:.leading) {
                            if flashcard.description.isEmpty {
                                Text("Enter description")
                                    .foregroundStyle(.gray)
                            }
                            TextField("", text: $flashcard.description)
                        }
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
                    VStack(alignment: .center, spacing: 25) {
                        // MARK: list of cards
                        ScrollView {
                            ForEach(flashcard.cards.indices, id: \.self) { index in
                                ZStack {
                                    RoundedRectangle(cornerRadius: 12)
                                        .frame(width:350,height:100)
                                        .foregroundStyle(.buttonColour)
                                    
                                    VStack {
                                        HStack {
                                            Text("Card \(index+1)")
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
                                        .padding(.horizontal,25)
                                        .padding(.top,20)
                                        
                                        HStack {
                                            ZStack(alignment:.leading) {
                                                if flashcard.description.isEmpty {
                                                    Text("Enter term")
                                                        .foregroundStyle(.gray)
                                                        .padding()
                                                }
                                                TextField("", text: $flashcard.cards[index].term)
                                                    .padding()
                                            }
                                            
                                            Spacer()
                                            
                                            ZStack(alignment:.leading) {
                                                if flashcard.description.isEmpty {
                                                    Text("Enter definition")
                                                        .foregroundStyle(.gray)
                                                        .padding()
                                                }
                                                TextField("", text: $flashcard.cards[index].definition)
                                                    .padding()
                                            }
                                        }
                                        .font(.custom("Futura Medium", size: 16))
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 25)
                                        
                                    }
                                }
                                .frame(width:350, height:100)
                                .padding(.top,10)
                                
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
                            
                        }
                        
                    }
                }
                .listRowBackground(Color.gray.opacity(0.3))
                
                // MARK: Practice section
                Section(header: Text("Study")
                    .font(.custom("Futura Medium", size: 23))
                    .foregroundStyle(.white)
                    .padding(.bottom,5)
                    .padding(.top,10)
                ) {
                    HStack(spacing:25) {
                        // MARK: Practice button
                        Button {

                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius:12)
                                    .frame(width:150,height:55)
                                    .foregroundStyle(.gradientTop)
                                
                                HStack {
                                    Text("Review")
                                    Image(systemName: "arrowshape.turn.up.left.fill")
                                        .bold()
                                }
                                .font(.custom("Futura Medium", size: 17))
                                .foregroundStyle(.white)
                            }
                        }
                        .padding(.top,20)
                        
                        // MARK: Test button
                        Button {

                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius:12)
                                    .frame(width:150,height:55)
                                    .foregroundStyle(.gradientTop)
                                
                                HStack {
                                    Text("Quiz")
                                    Image(systemName: "graduationcap.fill")
                                        .bold()
                                }
                                .font(.custom("Futura Medium", size: 17))
                                .foregroundStyle(.white)
                            }
                        }
                        .padding(.top,20)
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
                        onSave()
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
                        Text("Done")
                            .font(.custom("Futura Medium", size: 16))
                            .foregroundStyle(.tint)
                    }
                }
            }
            
        }
        
    }
    
}
