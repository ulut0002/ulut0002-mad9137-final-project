//
//  LanguageSelection.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-22.
//

import SwiftUI

struct LanguageSelectionView: View {
    @ObservedObject var appModel: AppModel
    @State var selectedLanguage: PreferredLanguage = .english
    @EnvironmentObject var appLanguageManager:AppLanguageManager

    
    var body: some View {
        HStack{
            Text("Language".localizeString(string: appLanguageManager.locale.identifier))
                .foregroundStyle(COLORS.DARK_TEXT_COLOR)
            Spacer()
            Picker("", selection: $selectedLanguage){
                Text("Language_English".localizeString(string: appLanguageManager.locale.identifier))
                    .tag(PreferredLanguage.english)
                    .foregroundStyle(COLORS.DARK_TEXT_COLOR)
                    .foregroundStyle(.blue)
                Text("Language_French".localizeString(string: appLanguageManager.locale.identifier))
                    .tag(PreferredLanguage.french)
                    .foregroundStyle(COLORS.DARK_TEXT_COLOR)
                
                
            }.foregroundStyle(COLORS.DARK_TEXT_COLOR)
            
        }.onAppear(){
            selectedLanguage = appModel.userConfig.preferredLanguage
        }.onChange(of: appModel.userConfig.preferredLanguage){
            selectedLanguage = appModel.userConfig.preferredLanguage
        }.onChange(of: selectedLanguage){ oldValue, newValue in
            appModel.setLanguage(language: newValue)
        }
    }
}
