//
//  Config.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-24.
//

import Foundation

struct CONFIGURATION {
    static let DATA_SOURCES:[String] = ["https://mocki.io/v1/f76d32b8-7520-4cb8-93f5-e15b89b91c4e"]
    static let STORAGE_KEY_ALL_BUILDINGS = "ALL_BUILDINGS"
    static let STORAGE_KEY_SAVED_BUILDINGS = "SAVED_BUILDINGS"
    static let STORAGE_KEY_CONFIGURATION = "USER_CONFIGURATION1"
    
    static let LANG_EN = "en"
    static let LANG_FR = "fr-CA"
    
    static let FILTER_VIEW_ICON_WIDTH:Double = 32.0
    static let FILTER_VIEW_ICON_HEIGHT:Double = 32.0
    
    
    static let BUILDING_VIEW_ICON_WIDTH:Double  = 32.0
    static let BUILDING_VIEW_ICON_HEIGHT:Double  = 32.0
    
    static let BUILDING_DESCRIPTION_SHORT_DESCRIPTION_LENGTH:Int = 150
    
    static let BUILDING_AMENITIES_SHORT_LENGTH:Int = 5
    
}



