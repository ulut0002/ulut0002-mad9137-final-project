//
//  MoreView.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-22.
//

import SwiftUI

struct MoreView: View {
    @ObservedObject var appModel:AppModel
    @EnvironmentObject var appLanguageManager:AppLanguageManager

    
    var body: some View {
        ZStack{
            Color.red
            
            VStack(){
              
                
                VStack{
                    MoreMenu(appModel: appModel)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            
            
        }
        
        
    }
    
}

struct MoreMenu:View{
    @ObservedObject var appModel: AppModel
    @EnvironmentObject var appLanguageManager:AppLanguageManager

    var body: some View{
        NavigationView{
            VStack{
                List {
                    LanguageSelectionView(appModel: appModel).padding(.top, 16)
                
                    NavigationLink("More_About_Event_Label".localizeString(string: appLanguageManager.locale.identifier), destination: AboutEventView())
                    
                    NavigationLink("More_About_Team_Label".localizeString(string: appLanguageManager.locale.identifier), destination: AboutTeamView())

                    
                    
                }.tint(COLORS.BRAND_COLOR)
                  
            }.listRowSeparator(.hidden)
           
            .listStyle(PlainListStyle())
                .toolbarBackground(COLORS.TOOLBAR_COLOR)
                .toolbarBackground(.visible, for: .navigationBar, .tabBar)
                .toolbar {
                    
                    ToolbarItem(placement: .topBarLeading){
                        Toolbar(title: "Toolbar_Title_More")
                    }
                }.frame(height: .infinity)
            
        }.tint(.white)
       
    }
}



