//
//  FlashcardContainer.swift
//  LockedInNoteCreate
//
//  Created by Kevin Nhan on 2026-01-12.
//

import SwiftUI

struct FlashcardContainer: View {
    @Binding var flashcards: [Flashcard]
    
    @State private var editingFlashcard = Flashcard(
        title: "",
        description: "",
        terms: 0,
        cards : []
    )

    @State private var selectedIndex: Int?
    @State private var isEditing = false

    var body: some View {
        ScrollView {
            ForEach(flashcards) { flashcard in
                Button {
                    let index = flashcards.firstIndex(of: flashcard)!
                    editingFlashcard = flashcards[index]
                    selectedIndex = index
                    isEditing = true
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 350, height: 100)
                            .foregroundStyle(.buttonColour)

                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(flashcard.title)
                                    .bold()
                                    .foregroundStyle(.white)

                                Text("\(flashcard.terms) Terms")
                                    .foregroundStyle(.gray)
                                    .font(.custom("Futura Medium", size: 15))
                            }
                            .font(.custom("Futura Medium", size: 17))
                            .padding(.leading, 25)

                            Spacer()

                            if let index = flashcards.firstIndex(of: flashcard) {
                                MenuFlashcard(
                                    flashcards: $flashcards,
                                    flashcard: $flashcards[index]
                                )
                                .padding(.trailing, 25)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                    }
                }
            }
        }
        .sheet(isPresented: $isEditing) {
            FlashcardStudySheet(
                flashcard: $editingFlashcard
            ) {
                if let index = selectedIndex {
                    flashcards[index] = editingFlashcard
                }
            }
        }

    }
}
