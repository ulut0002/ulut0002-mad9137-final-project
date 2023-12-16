//
//  Sort.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-28.
//

import Foundation


func compareBuildings(_ building1: Building,
                      _ building2: Building,
                      _ sortBy:SortBy) -> Bool {
   
    switch sortBy {
    case .alphabetical_asc:
        return building1.cleanSearchableName < building2.cleanSearchableName
    case .alphabetical_desc:
        return building1.cleanSearchableName > building2.cleanSearchableName
    case .distance_asc:
        if let distance1 = building1.distanceFromUserLocation, let distance2 = building2.distanceFromUserLocation {
            return distance1 < distance2
        }else{
          
//            print("sort problem \(String(describing: building1.distanceFromUserLocation))")
        }
        return false
    case .distance_desc:
        if let distance1 = building1.distanceFromUserLocation, let distance2 = building2.distanceFromUserLocation {
            return distance1 > distance2
        }
        return false
    }
}
