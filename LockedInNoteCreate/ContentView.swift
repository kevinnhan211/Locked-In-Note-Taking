//
//  ContentView.swift
//  LockedInNoteCreate
//
//  Created by Kevin Nhan on 2025-11-18.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                }
            
            StudyView()
                .tabItem {
                    Image(systemName: "pencil")
                }
        }

    }
}

#Preview {
    ContentView()
}
