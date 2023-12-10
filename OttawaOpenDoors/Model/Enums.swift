//
//  Enums.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-28.
//

import Foundation
import SwiftUI


enum PreferredLanguage:  Codable {
    case english
    case french
}


enum OttawaCoordinates:Double {
    case lat = 45.43020324663249
    case long =  -75.70920060238804
    
}

enum FetchStatus {
    case fetching
    case error
    case idle
}


enum SortBy {
    case alphabetical_asc
    case alphabetical_desc
    case distance_asc
    case distance_desc
}


enum BuildingFeature {
    case isNew
    case openSaturday
    case openSunday
    case shuttleBus
    case publicWashroom
    case accessible
    case freeParking
    case bikeParking
    case paidParking
    case guidedTour
    case familyFriendly
    case oCTranspoNearby
    
    
    var imageName: String {
        switch self {
        case .accessible: return "accessibility"
        case .bikeParking: return "bicycle.circle"
        case .familyFriendly : return "figure.2.and.child.holdinghands"
        case .freeParking : return "parkingsign.circle"
        case .guidedTour : return "headphones.circle"
        case .isNew : return "lightbulb.circle"
        case .oCTranspoNearby : return "bus"
        case .openSaturday : return "calendar"
        case .openSunday : return "calendar"
        case .paidParking : return "dollarsign.arrow.circlepath"
        case .publicWashroom : return "toilet"
        case .shuttleBus : return "bus.doubledecker.fill"
        }
    }
    
    var translation: LocalizedStringKey {
        switch self {
        case .accessible: return LocalizedStringKey("Feature_Accessible")
        case  .bikeParking: return LocalizedStringKey("Feature_Bike_Parking")
        case .familyFriendly : return LocalizedStringKey("Feature_Family_Friendly")
        case .freeParking : return LocalizedStringKey("Feature_Free_Parking")
        case .guidedTour : return LocalizedStringKey("Feature_Guided_Tour")
        case .isNew : return LocalizedStringKey("Feature_Is_New")
        case .oCTranspoNearby : return LocalizedStringKey("Feature_OC_Transpo_NearBy")
        case .openSaturday :return LocalizedStringKey("Feature_Open_Saturday")
        case .openSunday : return LocalizedStringKey("Feature_Open_Sunday")
        case .paidParking : return LocalizedStringKey("Feature_Paid_Parking")
        case .publicWashroom : return LocalizedStringKey("Feature_Public_Washroom")
        case .shuttleBus :return LocalizedStringKey("Feature_Shuttle_Bus")
        }
    }
    
    
    static func getAmenitiesAsArray() -> [BuildingFeature]{
        return [.accessible, .bikeParking, .familyFriendly, .freeParking, .guidedTour, .oCTranspoNearby, .paidParking, .publicWashroom, .shuttleBus]
    }
    
}


enum BuildingCategory {
    case community_center
    case religious_building
    case business_foundatation
    case museum_archive_historic
    case sports_leisure
    case gallery_theatre
    case other
    case functional_building
    case academic
    case government
    case embassy
    
    var imageName: String{
        switch self {
        case .academic: return "graduationcap.circle"
        case .business_foundatation: return "dollarsign.circle"
        case .religious_building: return "building"
        case .museum_archive_historic: return "building.columns.circle"
        case .sports_leisure: return "figure.run.circle"
        case .gallery_theatre: return "theatermasks.circle"
        case .other: return "questionmark.circle"
        case .functional_building: return "building.2"
        case .government: return "building.columns.circle"
        case .embassy: return "house.and.flag"
        case .community_center: return "person.2.wave.2.fill"
        }
    }
    
    static func resolveCategory(categoryId: Int) -> BuildingCategory{
        switch categoryId {
        case 5:
            return .academic
        case 8:
            return .business_foundatation
        case 7:
            return .community_center
        case 1:
            return .embassy
        case 3:
            return .functional_building
        case 4:
            return .gallery_theatre
        case 2:
            return .government
        case 9:
            return .museum_archive_historic
        case 10:
            return .other
        case 0:
            return .religious_building
        case 6:
            return .sports_leisure
        default:
            return .government
        }
    }
    
    
    var translation: LocalizedStringKey {
        switch self {
        case .academic: return LocalizedStringKey("Category_Academic")
        case  .business_foundatation: return LocalizedStringKey("Category_Business_Foundation")
        case .community_center : return LocalizedStringKey("Category_Community_Center")
        case .embassy : return LocalizedStringKey("Category_Embassy")
        case .functional_building : return LocalizedStringKey("Category_Functional_Building")
        case .gallery_theatre : return LocalizedStringKey("Category_Gallery_Theatre")
        case .government : return LocalizedStringKey("Category_Government")
        case .museum_archive_historic :return LocalizedStringKey("Category_Museum_Archive_Historic")
        case .other : return LocalizedStringKey("Category_Other")
        case .religious_building : return LocalizedStringKey("Category_Religious")
        case .sports_leisure : return LocalizedStringKey("Category_Sports_Leisure")
        }
    }
    
}
