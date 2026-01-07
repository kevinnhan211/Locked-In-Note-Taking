//
//  HomeView.swift
//  LockedInNoteCreate
//
//  Created by Kevin Nhan on 2025-11-22.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack{
            LinearGradient(colors: [.gradientTop, .gradientBottom], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            // Decorative background image
            Image("bubbleBG")
                .resizable()
                .scaledToFit()
                .opacity(0.25)
            
            VStack{
                
                HStack {
                    Text("Dashboard")
                        .font(.custom("Futura Medium", size: 30))
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .offset(x:18,y:2)
                    
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
            
                ScrollView {
                    Text("Good Afternoon, Kevin!")
                        .font(.custom("Futura Medium", size: 23))
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .padding(.trailing, 55)
                        .padding(.top,20)
                    
                    Text("Overview")
                        .font(.custom("Futura Medium", size: 23))
                        .foregroundStyle(.white)
                        .padding(.trailing, 245)
                        .padding(.top,20)
                    Overview()
                    
                    Stats()
                    
                    Text("Friends")
                        .font(.custom("Futura Medium", size: 23))
                        .foregroundStyle(.white)
                        .padding(.trailing, 270)
                        .padding(.top,20)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundStyle(.buttonColour)
                            .frame(width: 350, height: 115)
                        
                        HStack (alignment: .bottom, spacing: 30) {
                            FriendButton(bgColour: .blue, streak: 100)
                            FriendButton(bgColour: .red, streak: 56)
                            FriendButton(bgColour: .purple, streak: 384)
                            FriendButton(bgColour: .mint, streak: 274)
                            
                        }
                    }
                }
                
                
                Spacer()
            }
        }
    }
}

#Preview {
    HomeView()
}
