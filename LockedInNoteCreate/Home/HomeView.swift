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
                    Text("Overview")
                        .font(.custom("Futura Medium", size: 23))
                        .foregroundStyle(.white)
                        .padding(.trailing, 270)
                        .padding(.top,20)
                    overviewUI()
                    
                    ZStack {
                        RoundedRectangle(cornerRadius:12)
                            .foregroundStyle(.buttonColour)
                            .frame(width: 350,height:100)
                        Text("You've spent 10 hours studying this week.")
                            .font(.custom("Futura Medium", size: 18))
                            .foregroundStyle(.white)
                    }
                    .padding(.top,20)
                    
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius:12)
                                .foregroundStyle(.buttonColour)
                                .frame(width: 100,height:100)
                            Label {
                                Text("150%")
                            } icon: {
                                Image(systemName: "arrowshape.up.fill")
                                    .foregroundStyle(.green)
                            }
                            .font(.custom("Futura Medium", size: 18))
                            .foregroundStyle(.white)
                        }
                        .padding(.top,20)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius:12)
                                .foregroundStyle(.buttonColour)
                                .frame(width: 100,height:100)
                            Label {
                                Text("")
                            } icon: {
                                Image(systemName: "arrowshape.up.fill")
                                    .foregroundStyle(.green)
                            }
                            .font(.custom("Futura Medium", size: 18))
                            .foregroundStyle(.white)
                        }
                        .padding(.top,20)
                        
                    }
                    
                }
                
                
                Spacer()
            }
        }
    }
}

func overviewUI() -> some View {
    return ZStack{
        RoundedRectangle(cornerRadius:12)
            .foregroundStyle(.buttonColour)
            .frame(width: 350,height:100)
        
        HStack{
            // Streak
            Label {
                Text("1541 days")
                    .foregroundStyle(.white)
                    .font(.custom("Futura Medium", size: 16))
            } icon: {
                LinearGradient(colors: [.red, .orange, .yellow],
                               startPoint: .top,
                               endPoint: .bottom)
                .mask(
                    Image(systemName: "flame.fill")
                        .resizable()
                        .scaledToFit()
                )
                .frame(width: 20, height: 20)
            }
            .padding()
            
            // XP
            Label {
                Text("15400 XP")
                    .foregroundStyle(.white)
                    .font(.custom("Futura Medium", size: 16))
            } icon: {
                LinearGradient(colors: [.blue, .purple],
                               startPoint: .top,
                               endPoint: .bottom)
                .mask(
                    Image(systemName: "bolt.fill")
                        .resizable()
                        .scaledToFit()
                )
                .frame(width: 20, height: 20)
            }
        }
        .offset(x:-15)
    }
}

#Preview {
    HomeView()
}
