//
//  Overview.swift
//  LockedInNoteCreate
//
//  Created by Kevin Nhan on 2025-12-09.
//

import SwiftUI

struct Overview: View {
    var body: some View {
        ZStack{
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
}
