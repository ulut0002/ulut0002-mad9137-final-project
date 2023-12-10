//
//  ConfigModel.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-24.
//

import Foundation

struct ConfigModel: Codable{
    var languageCode: String
    var preferredLanguage: PreferredLanguage

    
    static func getDefaultConfigModel() -> ConfigModel{
        let langCode = findBestMatchingLanguageCode()
        let configModel:ConfigModel = ConfigModel(languageCode: langCode, preferredLanguage: langCode == CONFIGURATION.LANG_EN ? .english : .french)
      
        return configModel
    }
    
}



