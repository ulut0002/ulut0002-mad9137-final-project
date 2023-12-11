//
//  Building.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-24.
//

import Foundation
import MapKit
import SwiftUI


struct BookmarkInfo: Codable, Identifiable, Equatable, Hashable  {
    var id: Int
    var bookmarkDate: Date
    
    // Equatable conformance for comparison
    static func == (lhs: BookmarkInfo, rhs: BookmarkInfo) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
}


// MARK: Building Struct
struct Building: Codable, Identifiable, Equatable, Hashable {
    
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
    
    
    var bookmarkInfo: BookmarkInfo?
    var distanceFromUserLocation: Double?
    
    
    
    
    
    // https://stackoverflow.com/questions/26707352/how-to-split-filename-from-file-extension-in-swift
    var imageResourceName: String {
        if let image:String = self.image {
            return image.fileName()
        }
        return ""
    }
    
    var systemImage: String {
        let cat = BuildingCategory.resolveCategory(categoryId: self.categoryId ?? -1)
        return cat.imageName
    }
    
    
    
  

    // Equatable conformance for comparison
    static func == (lhs: Building, rhs: Building) -> Bool {
        return lhs.name?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() ==
        rhs.name?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    }
    
    var coordinate: CLLocationCoordinate2D? {
        if let latitude = self.latitude, let longitude = self.longitude {
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
        return nil
    }
    
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(buildingId)
//            hasher.combine(y)
        }
}


// MARK: Building Search / Filter functions
extension Building {
    
    // used in sorting by name
    var cleanSearchableName: String{
        if let name = self.name {
            return name.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        }
        return ""
    }
    
    func hasAnyFeature(features: [BuildingFeature]) -> Bool{
        if (features.isEmpty){
            return true
        }
        
        for feature in features {
            if (self.hasFeature(feature: feature)){
                return true
            }
        }
        
        return false
    }
    
    func hasFeature(feature: BuildingFeature) -> Bool{
        switch feature {
            case .accessible:
                return Bool(self.isAccessible ?? false)
            case .bikeParking:
                return Bool(self.isBikeParking ?? false)
            case .familyFriendly:
                return Bool(self.isFamilyFriendly ?? false)
            case .freeParking :
                return Bool(self.isFreeParking ?? false)
            case .guidedTour:
                return Bool(self.isGuidedTour ?? false)
            case .isNew:
                return Bool (self.isNew ?? false)
            case .oCTranspoNearby:
                return Bool(self.isOCTranspoNearby ?? false)
            case .openSaturday:
                return Bool(self.isOpenSaturday ?? false)
            case .openSunday:
                return Bool(self.isOpenSunday ?? false)
            case .paidParking:
                return Bool(self.isPaidParking ?? false)
            case .publicWashroom:
                return Bool(self.isPublicWashrooms ?? false)
            case .shuttleBus:
                return Bool(self.isShuttle ?? false)
            }
    }
    
    func hasCategory(category: BuildingCategory) -> Bool{
      return false
    }
    
    func hasAnyCategory(categoryFilterGroup: CategoryFilterGroup) -> Bool{
        if (categoryFilterGroup.hasAppliedAllFilters){
            return true
        }
        
        let categories = categoryFilterGroup.getAllOptionsAsArray()
            
        
        for category in categories {
            if (category.matchBuilding(building: self)){
                return true
            }

        }
        
        return false
    }
    
    func hasKeyword(searchKeyword: String) -> Bool {
        let cleanKeyword1 = searchKeyword.trimmingCharacters(in: .whitespacesAndNewlines)
        if (cleanKeyword1.isEmpty){
            return true
        }
        return searchText(source: self.name, lookFor: searchKeyword)
    }
}
