//
//  Building.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-24.
//

import Foundation





struct Building: Codable, Identifiable, Equatable {
    var id: Int {
        return buildingId
    }
    
    let buildingId: Int
    let name: String?
    let isNew: Bool?
    let address: String?
    let description: String?
    let website: String?
    let categoryId: Int?
    let category: String?
    let saturdayStart: String?
    let saturdayClose: String?
    let sundayStart: String?
    let sundayClose: String?
    let isShuttle: Bool?
    let isPublicWashrooms: Bool?
    let isAccessible: Bool?
    let isFreeParking: Bool?
    let isBikeParking: Bool?
    let isPaidParking: Bool?
    let isFamilyFriendly: Bool?
    let image: String?
    let isGuidedTour: Bool?
    let isOCTranspoNearby: Bool?
    let imageDescription: String?
    let latitude: Double?
    let longitude: Double?
    let isOpenSaturday: Bool?
    let isOpenSunday: Bool?
    
    // https://stackoverflow.com/questions/26707352/how-to-split-filename-from-file-extension-in-swift
    var imageResourceName: String {
        if let image:String = self.image {
            return image.fileName()
        }
        return ""
    }

    // Equatable conformance for comparison
    static func == (lhs: Building, rhs: Building) -> Bool {
        return lhs.name?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() ==
        rhs.name?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    }
}



