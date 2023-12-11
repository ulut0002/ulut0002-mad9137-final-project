//
//  Toolbar.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-12-04.
//

import SwiftUI

struct Toolbar: View {
    var title: String
    
    @EnvironmentObject var appLanguageManager: AppLanguageManager
    @State var toolBarLabel: String = ""
    var body: some View {
        Label(
            title: {
                HStack(alignment: .center){
                    AvatarView(image:  Image("ic_logo"), size: 32, color:.white)
                
                    Text(title.localizeString(string: appLanguageManager.locale.identifier))
                        .bold()
                        .font(.title3)
                        .padding(.leading, 4)
                        .foregroundStyle(COLORS.LIGHT_TEXT_COLOR)
                               
                    Spacer()
                }.padding(.vertical, 12)
            },
            icon: { Image(systemName: "42.circle") }
        ).labelStyle(TitleOnlyLabelStyle()).onAppear(){
            
        }
        
    }
}


