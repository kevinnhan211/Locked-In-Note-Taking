//
//  StudyView.swift
//  LockedInNoteCreate
//
//  Created by Kevin Nhan on 2025-11-19.
//

import SwiftUI

struct StudyView: View {
    @State private var notes : [String] = []
    @State private var search : String = ""
    
    @State private var tags : [String] = ["All Tags","Math", "Science", "Tech"]
    
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
                        notes.append("Untitled Note \(notes.count+1)")
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
                        ForEach(tags, id: \.self) { tag in
                            tagButton(name: tag)
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
                    ForEach(notes.enumerated(), id: \.element) {
                        index, note in
                        
                        noteButton(name : "\(note)") {
                            
                        }

                    }
                    
                }

                
                
                
                Spacer()
            }
            
            
        }
        
        
    }
}

func tagButton(name : String) -> some View {
    Button(action: {
        
    }) {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .frame(width: 100,height: 50)
                .foregroundStyle(.gray.opacity(0.5))
            
            Text("#\(name)")
                .font(.custom("Futura Medium", size: 17))
                .foregroundStyle(.gray)
        }
        
    }
}

func noteButton(name : String, action: @escaping () -> Void) -> some View {
    Button(action: action) {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 350, height: 100)
                .foregroundStyle(.buttonColour)
            
            HStack{
                VStack(alignment: .leading) {
                    Text(name)
                        .bold()
                        .foregroundStyle(.white)
                    
                    Text("Nov 21, 2025, 9:30 PM")
                        .foregroundStyle(.gray)
                }
                .font(.custom("Futura Medium", size: 17))
                .padding(.trailing, 100)
                .padding(.vertical, 10)    // ← this prevents clipping!
                
                Button(action:{
                    
                }) {
                    Image(systemName: "ellipsis")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25,height: 25)
                        .foregroundStyle(.gray)
                }
            }
        }
    }
}

#Preview {
    StudyView()
}
