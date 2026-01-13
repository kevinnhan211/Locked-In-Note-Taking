//
//  UserQuizView.swift
//  LockedInNoteCreate
//
//  Created by Kevin Nhan on 2026-01-11.
//

import SwiftUI

struct UserQuizView: View {
    @Binding var showUserQuiz : Bool
    
    @State private var flashcards : [Flashcard] = [
        Flashcard(
            title: "My Flashcard",
            terms : 0,
            cards : []
        )
    ]
    
    var body: some View {
        VStack {
            HStack {
                
                Button {
                    showUserQuiz = false
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .frame(width:120,height:45)
                            .foregroundStyle(Color.buttonColour)
                        
                        HStack {
                            Text("Back")
                            
                            Image(systemName: "arrowshape.turn.up.backward.fill")
                        }
                    }
                    .font(.custom("Futura Medium", size: 20))
                    .foregroundStyle(.white)
                    .offset(x:10)
                }
                
                Spacer()
                
                ZStack {
                    Image("LockInLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 60)
                        .opacity(0.65)
                    
                    Text("Locked In")
                        .font(.custom("Futura Medium", size: 16))
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                }
            }
            
            // MARK: Top bar
            HStack(spacing: 15) {
                Text("Your Library")
                    .font(.custom("Futura Medium", size: 24))
                    .bold()
                    .foregroundStyle(.white)
                    .offset(x:18,y:2)
                
                Spacer()
                
                // Add quiz button
                Button {
                    flashcards.append(
                        Flashcard(title: "Untitled Flashcard", terms: 0, cards : [])
                    )
                } label: {
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
                .offset(x: -25,y:2)
            }
            .padding(.top, 35)
            .padding(.bottom, 15)
            
            // MARK: Quiz making options
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(.buttonColour)
                    .frame(width: 350, height: 50)
                
                HStack(spacing: 35) {
                    Button{
                        
                    } label: {
                        Text("Flashcards")
                    }
                    
                    Button{
                        
                    } label: {
                        Text("Quizzes")
                    }
                    
                    Button{
                        
                    } label: {
                        Text("Practice tests")
                    }
                }
                .font(.custom("Futura Medium", size: 18)).fontWeight(.light)
                .foregroundStyle(.white)
            }
            .padding(.bottom,20)
            
            // MARK: User quizzes display
            FlashcardContainer(flashcards: $flashcards)
            
        }
        
        Spacer()
    }
    
    
}
