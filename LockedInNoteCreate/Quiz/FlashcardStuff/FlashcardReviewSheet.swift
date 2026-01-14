//
//  FlashcardReviewSheet.swift
//  LockedInNoteCreate
//
//  Created by Kevin Nhan on 2026-01-14.
//

import SwiftUI

struct FlashcardReviewSheet: View {
    @Binding var showScreen : Bool
    @Binding var flashcard : Flashcard
    
    @Environment(\.dismiss) var dismiss
    
    @State private var currentText : String = ""
    @State private var currentIndex : Int = 0
    @State private var onTermSide : Bool = true
    
    private var displayedText: String {
        guard flashcard.cards.indices.contains(currentIndex) else { return "" }
        return onTermSide
            ? flashcard.cards[currentIndex].term
            : flashcard.cards[currentIndex].definition
    }
    
    var body: some View {
        NavigationView {
            Form {
                // MARK: Title
                Section(header: Text("Current Card")
                    .font(.custom("Futura Medium", size: 23))
                    .foregroundStyle(.white)
                    .padding(.bottom,5)
                    .padding(.top,10)
                ) {
                    VStack (spacing: 25) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundColor(.white)
                                .shadow(color: Color.gray.opacity(0.1), radius: 10)

                            Text(displayedText)
                                .font(.custom("Futura Medium", size: 23))
                                .foregroundStyle(.black)
                                .multilineTextAlignment(.center)
                                .lineLimit(nil)
                                .fixedSize(horizontal: false, vertical: true)
                                .padding(24)
                        }
                        .frame(maxWidth: 350, minHeight: 250)

                        
                        HStack {
                            // MARK: Back button
                            Button {
                                currentIndex = max(0, currentIndex - 1)
                                onTermSide = true
                                print(currentIndex)
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius:12)
                                        .foregroundStyle(.gradientTop)
                                    
                                    HStack {
                                        Text("Back")
                                    }
                                    .font(.custom("Futura Medium", size: 14))
                                    .foregroundStyle(.white)
                                }
                                .frame(width:50,height:55)
                            }
                            .buttonStyle(.plain)
                            .contentShape(Rectangle())
                            
                            // MARK: Next button
                            Button {
                                let lastIndex = flashcard.cards.count - 1
                                currentIndex = min(lastIndex, currentIndex + 1)
                                onTermSide = true
                                print(currentIndex)
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius:12)
                                        .foregroundStyle(.gradientTop)
                                    
                                    HStack {
                                        Text("Next")
                                    }
                                    .font(.custom("Futura Medium", size: 14))
                                    .foregroundStyle(.white)
                                }
                                .frame(width:50,height:55)
                            }
                            .buttonStyle(.plain)
                            .contentShape(Rectangle())
                            
                            Spacer()
                            
                            // MARK: flip button
                            Button {
                                onTermSide.toggle()
                                print(onTermSide)
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius:12)
                                        .foregroundStyle(.gradientTop)
                                    
                                    HStack {
                                        Text("Flip")
                                    }
                                    .font(.custom("Futura Medium", size: 14))
                                    .foregroundStyle(.white)
                                }
                                .frame(width:100,height:55)
                            }
                            .buttonStyle(.plain)
                            .contentShape(Rectangle())
                        }
                    }
                }
                .listRowBackground(Color.gray.opacity(0))
                
                
            }
            .scrollContentBackground(.hidden)
            .background(Color.buttonColour)
            
            .navigationBarTitleDisplayMode(.inline)
            
            // MARK: Middle title context
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Reviewing Flashcard")
                        .font(.custom("Futura Medium", size: 16))
                        .foregroundColor(.white)
                    
                }
            }
            
            // MARK: Exit button
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action:{
                        showScreen = false
                    }) {
                        Text("Back")
                            .font(.custom("Futura Medium", size: 16))
                            .foregroundStyle(.tint)
                    }
                }
            }
        
        }
        
    }
}
