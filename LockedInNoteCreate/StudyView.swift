//
//  StudyView.swift
//  LockedInNoteCreate
//
//  Created by Kevin Nhan on 2025-11-19.
//

import SwiftUI

struct StudyView: View {
    @State private var notes : [String] = ["hi","test"]
    @State private var search : String = ""
    
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
                        .foregroundStyle(.white)
                        .offset(x:18,y:2)
                    
                    Spacer()
                    
                    Button(action:{
                        
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

                }
                .offset(y:10)
                
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
                    ForEach(notes.enumerated(), id: \.element) {
                        index, note in
                        
                        Button(action:{
                            
                        }) {
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 350,height: 100)
                                    .foregroundStyle(.white)
                            }
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
