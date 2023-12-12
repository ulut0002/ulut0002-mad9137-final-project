//
//  LanguageSelection.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-22.
//

import SwiftUI

struct LanguageSelectionView: View {
    @ObservedObject var appModel: AppModel
    @State var selectedLanguage: PreferredLanguage = .unknown
    @EnvironmentObject var appLanguageManager:AppLanguageManager
    @State private var isInitialSetup = true

    
    var body: some View {
        HStack{
            
                                  
            
            Text("Language".localizeString(string: appLanguageManager.locale.identifier))
                .foregroundStyle(COLORS.DARK_TEXT_COLOR)
            Spacer()
            if (selectedLanguage == .english || selectedLanguage == .french){
                
                Picker("", selection: $selectedLanguage){
                    Text("Language_English".localizeString(string: appLanguageManager.locale.identifier))
                        .tag(PreferredLanguage.english)
                        .foregroundStyle(COLORS.DARK_TEXT_COLOR)
                        .foregroundStyle(.blue)
                    Text("Language_French".localizeString(string: appLanguageManager.locale.identifier))
                        .tag(PreferredLanguage.french)
                        .foregroundStyle(COLORS.DARK_TEXT_COLOR)
                    
                    
                }
                .foregroundStyle(COLORS.DARK_TEXT_COLOR)
            }
            
        } .onAppear(){
            if (appLanguageManager.locale.identifier == CONFIGURATION.LANG_EN){
                selectedLanguage = .english

            }else if (appLanguageManager.locale.identifier == CONFIGURATION.LANG_FR){
                selectedLanguage = .french

            }
            
        }.onChange(of: appModel.userConfig.preferredLanguage){

        }
        .onChange(of: selectedLanguage){ oldValue, newValue in
            if (selectedLanguage == .english || selectedLanguage == .french){
                if (!isInitialSetup){
                    appModel.setLanguage(language: newValue)
                  
                }else{
                    isInitialSetup = false
                }
                
            }
        
       
    }
    }
}
