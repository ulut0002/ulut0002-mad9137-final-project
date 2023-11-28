//
//  Enums.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-28.
//

import Foundation


enum PreferredLanguage {
    case english
    case french
}


enum FetchStatus {
    case fetchingFirstTime
    case reFetching
    case error
    case idle
}


enum SortBy {
    case alphabetical
    case distance
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
}
