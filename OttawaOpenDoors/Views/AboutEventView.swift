//
//  AboutEvent.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-12-10.
//

import SwiftUI

struct AboutEventView: View {
    @EnvironmentObject var appLanguageManager: AppLanguageManager
    
    var body: some View {
        //        NavigationView{
        ScrollView{
            VStack(alignment: .center){
                Image("placeHolderLogoFaded").resizable().aspectRatio(contentMode: .fit).frame(width: 200,height: 300)
                VStack(alignment: .leading, spacing: 12 ){
                    Text("About_Event_Description_P1".localizeString(string: appLanguageManager.locale.identifier))
                    Text("About_Event_Description_P2".localizeString(string: appLanguageManager.locale.identifier))
                    
                    Text("About_Event_Description_P3".localizeString(string: appLanguageManager.locale.identifier))
                    
                }
                
                Spacer()
                
            }.padding()
        }
        .toolbarBackground(.visible, for: .navigationBar, .tabBar)
        .toolbarBackground(COLORS.TOOLBAR_COLOR)
        .toolbar {
            ToolbarItem(placement: .principal){
                Text("More_About_Event_Label".localizeString(string: appLanguageManager.locale.identifier))
                    .bold()
                    .font(.title3)
                    .padding(.leading, 4)
                    .foregroundStyle(COLORS.LIGHT_TEXT_COLOR)
            }
            
            
        }.tint(.white)
        
        //        }
    }
}
