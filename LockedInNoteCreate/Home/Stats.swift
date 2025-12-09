//
//  Stats.swift
//  LockedInNoteCreate
//
//  Created by Kevin Nhan on 2025-12-09.
//

import SwiftUI

struct Stats: View {
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius:12)
                    .foregroundStyle(.buttonColour)
                    .frame(width: 250,height:100)
                Text("You've spent 10 hours studying this week.")
                    .font(.custom("Futura Medium", size: 16))
                    .foregroundStyle(.white)
            }
            .padding(.top,20)
            
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
            .padding(.top,20)
            
            ZStack {
                RoundedRectangle(cornerRadius:12)
                    .foregroundStyle(.buttonColour)
                    .frame(width: 250,height:100)
                Text("You've spent less time on social media! Keep it up!")
                    .frame(width:230,height:100)
                    .font(.custom("Futura Medium", size: 16))
                    .foregroundStyle(.white)
            }
            .padding(.top,20)
        }
        
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius:12)
                    .foregroundStyle(.buttonColour)
                    .frame(width: 100,height:100)
                Label {
                    Text("74%")
                } icon: {
                    Image(systemName: "")
                        .foregroundStyle(.red)
                }
                .font(.custom("Futura Medium", size: 18))
                .foregroundStyle(.white)
            }
            .padding(.top,20)

        }
    }
}

#Preview {
    Stats()
}
