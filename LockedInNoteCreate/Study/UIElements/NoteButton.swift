//
//  NoteButton.swift
//  LockedInNoteCreate
//
//  Created by Kevin Nhan on 2025-12-01.
//

import SwiftUI

struct NoteButton: View {
    var name: String
    var dateString: Date
    var action: () -> Void
    var menuAction: () -> Void = {}
    
    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.buttonColour)
                
                HStack {
                    // LEFT SIDE
                    VStack(alignment: .leading, spacing: 4) {
                        Text(name)
                            .bold()
                            .foregroundStyle(.white)
                        
                        Text(dateString,
                             format: .dateTime.month(.wide).day().year().hour().minute())
                            .foregroundStyle(.gray)
                    }
                    .font(.custom("Futura Medium", size: 17))
                    
                    Spacer()   // ← pushes ellipsis button to the right
                    
                    // RIGHT SIDE BUTTON
                    Button(action: menuAction) {
                        Image(systemName: "ellipsis")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(.gray)
                    }
                    .buttonStyle(.plain) // prevents outer button from triggering
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
            }
            .frame(width: 350, height: 100)
        }
        .buttonStyle(.plain) // keeps the custom appearance
    }
}
