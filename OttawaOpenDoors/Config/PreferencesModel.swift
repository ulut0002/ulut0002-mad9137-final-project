//
//  PreferencesModel.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-24.
//

import Foundation

enum BUILDING_SORT_ORDER:Codable {
    case name_asc
    case name_desc
    case distance_asc
    case distance_desc
    
    static func == (lhs: BUILDING_SORT_ORDER, rhs: BUILDING_SORT_ORDER) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

class PreferencesModel:ObservableObject{
    @Published var sortOrder:BUILDING_SORT_ORDER = .name_asc
    
    
}


struct UserPreference: Codable, Identifiable, Equatable{
    var id: String {
        return "UserPreferences"
    }
    var sortOrder:BUILDING_SORT_ORDER = .name_asc
    
    // Equatable conformance for comparison
    static func == (lhs: UserPreference, rhs: UserPreference) -> Bool {
        return true
    }
}
