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
  
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
            }
            .frame(width: 350, height: 100)
        }
        .buttonStyle(.plain) // keeps the custom appearance
    }
}
