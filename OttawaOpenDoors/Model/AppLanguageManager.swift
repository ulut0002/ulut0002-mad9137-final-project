//
//  LanguageSetting.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-12-10.
//

import Foundation


// source: https://stackoverflow.com/questions/77337926/how-to-change-the-language-without-leaving-the-application-on-swiftui
class AppLanguageManager: ObservableObject{
    @Published var locale = Locale(identifier: CONFIGURATION.LANG_EN)
    
    func setLocale(_ newLocale: Locale) {
           self.locale = newLocale
    }
}
