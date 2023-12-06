//
//  BuildingViewMap.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-12-06.
//

import SwiftUI
import MapKit

struct BuildingViewMap: View {
    var building: Building
    @State private var region: CLLocationCoordinate2D? = nil
    
    var body: some View {
        VStack{
            Map(){
                if (region != nil) {
                    Marker("Test", coordinate: region!)
                }
                
            }
        }.onAppear(){
            if let latitude = building.latitude, let longitude = building.longitude{
               
                region = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                print("region is nil = \(region!)")
            }
        }
    
    }
}

