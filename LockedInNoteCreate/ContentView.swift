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
                    Label("Home", systemImage:"house.fill")
                }
            
            StudyView()
                .tabItem {
                    Label("Notes", systemImage:"note")
                }
            
//            MainShopView()
//                .tabItem {
//                    Label("Shop", systemImage:"cart")
//                }
        }

    }
}

#Preview {
    ContentView()
}
