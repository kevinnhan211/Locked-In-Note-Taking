//
//  Stats.swift
//  LockedInNoteCreate
//
//  Created by Kevin Nhan on 2025-12-09.
//

import SwiftUI

struct Stats: View {
    var body: some View {
        Text("Progress")
            .font(.custom("Futura Medium", size: 23))
            .foregroundStyle(.white)
            .padding(.trailing, 255)
            .padding(.top,20)
        
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius:12)
                    .foregroundStyle(.buttonColour)
                    .frame(width: 250,height:100)
                Text("You've spent 10 hours studying this week.")
                    .font(.custom("Futura Medium", size: 16))
                    .foregroundStyle(.white)
            }
            
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
        }
        
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius:12)
                    .foregroundStyle(.buttonColour)
                    .frame(width: 100,height:100)
                Label {
                    Text("74%")
                } icon: {
                    Image(systemName: "arrowshape.down.fill")
                        .foregroundStyle(.red)
                }
                .font(.custom("Futura Medium", size: 18))
                .foregroundStyle(.white)
            }
            
            ZStack {
                RoundedRectangle(cornerRadius:12)
                    .foregroundStyle(.buttonColour)
                    .frame(width: 250,height:100)
                Text("You've spent less time on social media! Keep it up!")
                    .frame(width:230,height:100)
                    .font(.custom("Futura Medium", size: 16))
                    .foregroundStyle(.white)
            }
        }
        
        Text("Notifications")
            .font(.custom("Futura Medium", size: 23))
            .foregroundStyle(.white)
            .padding(.trailing, 225)
            .padding(.top,20)
        
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius:12)
                    .foregroundStyle(.buttonColour)
                    .frame(width: 100,height:100)
                Label {
                    Text("17 hr")
                } icon: {
                    Image(systemName: "hourglass")
                        .foregroundStyle(.brown)
                }
                .font(.custom("Futura Medium", size: 18))
                .foregroundStyle(.white)
            }

            ZStack {
                RoundedRectangle(cornerRadius:12)
                    .foregroundStyle(.buttonColour)
                    .frame(width: 250,height:100)
                Text("Your Calculus assignment is due in a day.")
                    .frame(width:230,height:100)
                    .font(.custom("Futura Medium", size: 16))
                    .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    Stats()
}
