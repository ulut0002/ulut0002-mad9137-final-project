//
//  AboutDeveloperView.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-12-10.
//

import SwiftUI

struct AboutDeveloperView: View {
    @EnvironmentObject var appLanguageManager: AppLanguageManager
    
    var body: some View {
        ScrollView{
            VStack(alignment: .center){
                Image("me").resizable().aspectRatio(contentMode: .fit).frame(width: 200,height: 300)
                
                HStack{
                    VStack(alignment: .leading, spacing: 12){
                        Text("Serdar Ulutas").bold().font(.title2)
                        Text("IOS_Developer".localizeString(string: appLanguageManager.locale.identifier)).bold().font(.caption).foregroundStyle(COLORS.DARK_TEXT_COLOR_LIGHT)
                    }
                    Spacer()
                }
                
                Divider()
                
                VStack{
                    HStack{
                        Image(systemName: "envelope.fill")
                        Text("ulut0002@algonquinlive.com").foregroundStyle(COLORS.DARK_TEXT_COLOR)
                        Spacer()
                    }

                }.padding(.vertical, 24)
                
                Divider().padding(.bottom, 24)
         
                
               
                
                
                Spacer()
                
            }.padding()
                .tint(.black)
            
            
            
        }
        .toolbarBackground(.visible, for: .navigationBar, .tabBar)
        .toolbarBackground(COLORS.TOOLBAR_COLOR)
        .toolbar {
            ToolbarItem(placement: .principal){
                Text("More_About_Serdar_Title".localizeString(string: appLanguageManager.locale.identifier))
                    .bold()
                    .font(.title3)
                    .padding(.leading, 4)
                    .foregroundStyle(COLORS.LIGHT_TEXT_COLOR)
            }
            
            
        }.tint(.white)
        
    }
}
