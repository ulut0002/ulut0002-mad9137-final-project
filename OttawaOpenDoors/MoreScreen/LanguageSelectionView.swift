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
    
    var body: some View {
        HStack{
            Text("Language").bold()
            Spacer()
            Picker("", selection: $selectedLanguage){
                Text("English").tag(PreferredLanguage.english)
                Text("French").tag(PreferredLanguage.french)
            }.onSubmit {
               
            }
            
        }.onAppear(){
            selectedLanguage = appModel.userConfig.preferredLanguage
        }.onChange(of: appModel.userConfig.preferredLanguage){
            selectedLanguage = appModel.userConfig.preferredLanguage
        }.onChange(of: selectedLanguage){ oldValue, newValue in
            appModel.setLanguage(language: newValue)
        }
    }
}
