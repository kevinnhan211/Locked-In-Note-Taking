//
//  ShopView.swift
//  LockedInNoteCreate
//
//  Created by Kevin Nhan on 2025-12-09.
//

import SwiftUI

struct ShopView: View {
    var body: some View {
        ZStack{
            LinearGradient(colors: [.gradientTop, .gradientBottom], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            // Decorative background image
            Image("bubbleBG")
                .resizable()
                .scaledToFit()
                .opacity(0.25)
            
            ScrollView{
                HStack {
                    Text("Shop")
                        .font(.custom("Futura Medium", size: 30))
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .offset(x:18,y:2)
                    
                    Spacer()
                    
                    HStack{
                        Image("flame")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 45,height: 60)
                        Text("26,409")
                            .font(.custom("Futura Medium", size: 25))
                            .fontWeight(.ultraLight)
                            .foregroundStyle(.white)
                            .offset(x:-10)
                    }
                    .offset(x:-20,y:5)
                }
                
                Text("Bundles")
                    .font(.custom("Futura Medium", size: 23))
                    .foregroundStyle(.white)
                    .padding(.trailing, 245)
                    .padding(.top,20)
                
                ZStack {
                    RoundedRectangle(cornerRadius:12)
                        .foregroundStyle(.buttonColour)
                        .frame(width: 350,height:100)
                    Text("No bundles available. Check back soon!")
                        .font(.custom("Futura Medium", size: 16))
                        .foregroundStyle(.white)
                }
                
                Text("Currency")
                    .font(.custom("Futura Medium", size: 23))
                    .foregroundStyle(.white)
                    .padding(.trailing, 245)
                    .padding(.top,20)
                
                ZStack {
                    RoundedRectangle(cornerRadius:12)
                        .foregroundStyle(.buttonColour)
                        .frame(width: 350,height:250)
                    Text("Work in progress!")
                        .font(.custom("Futura Medium", size: 16))
                        .foregroundStyle(.white)
                }
                
                Text("Avatar Cosmetics")
                    .font(.custom("Futura Medium", size: 23))
                    .foregroundStyle(.white)
                    .padding(.trailing, 155)
                    .padding(.top,20)
                
                ZStack {
                    RoundedRectangle(cornerRadius:12)
                        .foregroundStyle(.buttonColour)
                        .frame(width: 350,height:250)
                    Text("Work in progress!")
                        .font(.custom("Futura Medium", size: 16))
                        .foregroundStyle(.white)
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    ShopView()
}
