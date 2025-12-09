//
//  FriendButton.swift
//  LockedInNoteCreate
//
//  Created by Kevin Nhan on 2025-12-09.
//

import SwiftUI

struct FriendButton: View {
    var bgColour : Color
    var streak : Int
    
    var body: some View {
        VStack {
            Button(action:{
                
            }) {
                
                Image(systemName: "person.fill")
                    .scaleEffect(3)
                    .frame(width: 55, height: 55)
                    .background(bgColour.opacity(0.6))
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .foregroundStyle(.white)
                
                
            }
            
            Label {
                Text("\(streak)")
                    .foregroundStyle(.white)
                    .font(.custom("Futura Medium", size: 14))
            } icon: {
                LinearGradient(colors: [.red, .orange, .yellow],
                               startPoint: .top,
                               endPoint: .bottom)
                .mask(
                    Image(systemName: "flame.fill")
                        .resizable()
                        .scaledToFit()
                )
                .frame(width: 15, height: 15)
            }
        }
    }
}
