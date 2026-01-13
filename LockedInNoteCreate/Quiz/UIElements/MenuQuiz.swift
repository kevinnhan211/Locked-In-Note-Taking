//
//  MenuQuiz.swift
//  LockedInNoteCreate
//
//  Created by Kevin Nhan on 2026-01-12.
//

import SwiftUI

struct MenuFlashcard: View {
    @Binding var flashcards : [Flashcard]
    @Binding var flashcard : Flashcard
    
    @State private var warning = false
    
    var body: some View {
        ZStack {
            Menu {
                Button {
                    
                } label: {
                    Label("Edit", systemImage: "pencil")
                }
                
                Button {
                    
                } label: {
                    Label("Export", systemImage: "square.and.arrow.up.badge.clock")
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
            .alert("Delete Note", isPresented: $warning) {
                Button(role: .cancel) {
                    warning = false
                }
                
                Button(role: .destructive) {
                    flashcards.removeAll(where: { $0.id == flashcard.id })
                }
                
            }
        }
    }
}
