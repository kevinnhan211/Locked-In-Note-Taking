//
//  InventoryView.swift
//  LockedInNoteCreate
//
//  Created by Kevin Nhan on 2025-12-09.
//

import SwiftUI

struct InventoryView: View {
    var body: some View {
        ZStack{
            LinearGradient(colors: [.gradientTop, .gradientBottom], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            // Decorative background image
            Image("bubbleBG")
                .resizable()
                .scaledToFit()
                .opacity(0.25)
            
            VStack (alignment: .leading) {
                HStack {
                    Text("Inventory")
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
                
                Text("Your Character")
                    .font(.custom("Futura Medium", size: 23))
                    .foregroundStyle(.white)
                    .padding(.leading, 20)
                    .padding(.top,20)
                
                
                ZStack {
                    RoundedRectangle(cornerRadius:12)
                        .foregroundStyle(.buttonColour.opacity(0.75))
                        .frame(width: 230,height:275)
                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.white, lineWidth: 4))
                    
                    Image("templateRobotAvatar")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200,height: 200)
                }
                .padding(.leading,20)
                
                Button(action:{
                    
                }) {
                    Label{
                        Text("Customize")
                            .foregroundStyle(.white)
                            .font(.custom("Futura Medium", size: 18))
                    } icon: {
                        Image(systemName: "hanger")
                            .resizable()
                            .foregroundStyle(.white)
                            .frame(width: 20,height: 20)
                    }
                }
                .padding(.leading,20)
                .padding(.top,20)
                
                Text("Items")
                    .font(.custom("Futura Medium", size: 23))
                    .foregroundStyle(.white)
                    .padding(.leading, 20)
                    .padding(.top,20)
                
                ZStack {
                    RoundedRectangle(cornerRadius:12)
                        .foregroundStyle(.buttonColour)
                        .frame(width: 350,height:100)
                    Text("No items.")
                        .font(.custom("Futura Medium", size: 16))
                        .foregroundStyle(.white)
                }
                .padding(.leading,20)
                
                Spacer()
            }
        }
    }
}

#Preview {
    InventoryView()
}
