//
//  TagButton.swift
//  LockedInNoteCreate
//
//  Created by Kevin Nhan on 2025-12-01.
//

import SwiftUI

struct TagButton: View {
    @Binding var tag : Tag
    
    var body: some View {
        Button(action: {
            $tag.wrappedValue.active = !$tag.wrappedValue.active
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: 100,height: 50)
                    .foregroundStyle(.gray.opacity(0.5))
                
                Text("#\($tag.wrappedValue.name)")
                    .font(.custom("Futura Medium", size: 17))
                    .foregroundStyle($tag.wrappedValue.active ? .white : .gray)
            }
            
        }
    }
}
