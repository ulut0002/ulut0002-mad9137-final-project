//
//  AboutTeamView.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-12-10.
//

import SwiftUI

struct AboutTeamView: View {
    @EnvironmentObject var appLanguageManager: AppLanguageManager
    
    @State var developerLinkActive: Bool = false
    
    var body: some View {
            ScrollView{
                VStack(alignment: .center, spacing: 12){
                    Image("steps").resizable().aspectRatio(contentMode: .fit).frame(width: 80,height: 80)
                    
                    Text("More_About_Team_Name".localizeString(string: appLanguageManager.locale.identifier))
                        .bold()
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                    
                    Text("More_About_Team_Description".localizeString(string: appLanguageManager.locale.identifier))
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                    
              
                    
                    NavigationLink(destination: AboutDeveloperView()){
                        HStack{
                            VStack(alignment: .leading){
                                Text("Serdar Ulutas")
                                    .font(.title3)
                                    .foregroundStyle(COLORS.BRAND_COLOR)
                                    .bold()
                                Text("More_About_Serdar_Position".localizeString(string: appLanguageManager.locale.identifier)).foregroundStyle(COLORS.DARK_TEXT_COLOR_LIGHT)
                            }
                            Spacer()
                        }
                        .padding(.top, 24)
                    }
                    

//                    
                }.padding(24)
            }
            .toolbarBackground(.visible, for: .navigationBar, .tabBar)
            .toolbarBackground(COLORS.TOOLBAR_COLOR)
            .toolbarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal){
                    Text("More_About_Team_Label".localizeString(string: appLanguageManager.locale.identifier))
                        .bold()
                        .font(.title3)
                        .padding(.leading, 4)
                        .foregroundStyle(COLORS.LIGHT_TEXT_COLOR)
                }
                
                
            }.tint(.white)
            
        }
    
}
