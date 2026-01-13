//
//  QuizView.swift
//  LockedInNoteCreate
//
//  Created by Kevin Nhan on 2026-01-11.
//

import SwiftUI

struct QuizView: View {
    @State private var showUserQuizzes = false
    @State private var showCommunityQuizzes = false

    var body: some View {
        ZStack {
            LinearGradient(colors: [.gradientTop, .gradientBottom], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            // Decorative background image
            Image("bubbleBG")
                .resizable()
                .scaledToFit()
                .opacity(0.25)
            
            if showUserQuizzes {
                UserQuizView(showUserQuiz: $showUserQuizzes)
            }
            
            else {
                VStack {
                    HStack {
                        Text("Study")
                            .font(.custom("Futura Medium", size: 30))
                            .bold()
                            .foregroundStyle(.white)
                            .offset(x:18,y:2)
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text("Quizzes")
                            .font(.custom("Futura Medium", size: 24))
                            .bold()
                            .foregroundStyle(.white)
                            .offset(x:18,y:2)
                        
                        Spacer()
                    }
                    .padding(.top, 35)
                    .padding(.bottom, 20)
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundStyle(.buttonColour)
                            .frame(width:350, height: 200)
                        
                        VStack(alignment:.trailing) {
                            Button(action:{
                            }) {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 25)
                                        .frame(width:250,height:35)
                                        .foregroundStyle(Color.gradientTop.opacity(0.3))
                                    
                                    HStack {
                                        Text("Community Made")
                                        Image(systemName: "arrowshape.right.fill")
                                        
                                    }
                                    .font(.custom("Futura Medium", size: 18))
                                    .foregroundStyle(.white)
                                }
                            }
                            
                            Button(action:{
                                showUserQuizzes = true
                            }) {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 25)
                                        .frame(width:250,height:35)
                                        .foregroundStyle(Color.gradientTop.opacity(0.3))
                                    
                                    HStack {
                                        Text("Your Quizzes")
                                        Image(systemName: "arrowshape.right.fill")
                                        
                                    }
                                    .font(.custom("Futura Medium", size: 18))
                                    .foregroundStyle(.white)
                                }
                            }
                        }
                    }
                    
                    // MARK: Recommendation
                    HStack {
                        Text("Recommendations")
                            .font(.custom("Futura Medium", size: 24))
                            .bold()
                            .foregroundStyle(.white)
                            .offset(x:18,y:2)
                        
                        Spacer()
                    }
                    .padding(.top, 35)
                    .padding(.bottom, 20)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundStyle(.buttonColour)
                            .frame(width:350, height: 200)
                        
                        VStack (spacing: 25) {
                            Text("From your recent activities, check out our community made Chemistry quizzes!")
                                .font(.custom("Futura Medium", size: 18))
                                .padding(.bottom,15)
                            
                            // Recent quizzes
                            Button {
                                
                            } label: {
                                HStack {
                                    Text("Recent Quizzes")
                                    Image(systemName: "arrowshape.right.fill")
                                }
                                .foregroundStyle(.tint)
                                .font(.custom("Futura Medium", size: 18))
                                
                            }
                        }
                    }
                    .foregroundStyle(.white)
                    
                    Spacer()
                }
            }
        }
        
    }
}

#Preview {
    QuizView()
}
