//
//  ConfigModel.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-24.
//

import Foundation

struct ConfigModel: Codable{
    var lang: String
    var preferredLanguage: PreferredLanguage
    
    // https://stackoverflow.com/questions/58673183/how-to-change-localization-on-the-fly-swiftui
    var bundle: Bundle? {
        let b = Bundle.main.path(forResource: lang, ofType: "lproj")!
        return Bundle(path: b)
    }
    
    
    static func getDefaultConfigModel() -> ConfigModel{
        let langCode = findBestMatchingLanguageCode()
        let configModel:ConfigModel = ConfigModel(lang: langCode, preferredLanguage: langCode == CONFIGURATION.LANG_EN ? .english : .french)
        
        return configModel
    }
    
}



