//
//  MainShopView.swift
//  LockedInNoteCreate
//
//  Created by Kevin Nhan on 2025-12-09.
//

import SwiftUI

struct MainShopView: View {
    var body: some View {
        TabView {
            ShopView()
            InventoryView()
        }
        .background(Gradient(colors : [.gradientTop,.gradientBottom]))
        .tabViewStyle(.page)
    }
}

#Preview {
    MainShopView()
}
