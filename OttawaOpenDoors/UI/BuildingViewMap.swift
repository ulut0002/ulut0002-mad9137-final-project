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
    @State private var position : MapCameraPosition = .automatic

    @State private var region: CLLocationCoordinate2D? = nil
    @State var distanceInKm : Double? = nil
    @State var distanceInKmText = ""
    
    @EnvironmentObject var locationManager:LocationManager
    
    var body: some View {
        VStack{
            HStack{
                Button{
                    
//                    position = building.coordinate
                    if let coordinate = building.coordinate {
//                        position = MapCameraPosition.region(MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000))
                        position = MapCameraPosition.region(MKCoordinateRegion(center: coordinate, span: position.region?.span ?? MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)))

                    }
                   
                }label: {
                    Text(localizedString(forKey:"Building_View_Recenter_Map"))
                        .foregroundStyle(COLORS.TEXT_BUTTON_BLUE)
                        .font(.subheadline)
                }
                Spacer()
                
                Text(distanceInKmText)
                    .font(.caption2)
                    .foregroundStyle(COLORS.DARK_TEXT_COLOR_LIGHT)
                
            }.padding(.horizontal)
            
            
            Map(position: $position){
             
                
                if let region = region {
                    Marker(building.name ?? localizedString(forKey:  "Building_View_Default_Name") , coordinate: region)
                                }
                
            }.mapControls{
                MapUserLocationButton()
                MapCompass()
                MapScaleView()
                MapPitchToggle()


            }
            .mapControlVisibility(.visible)
//            .lay
            
            HStack{
                Text(building.address ?? "")
                    .font(.body)
                    .foregroundStyle(COLORS.DARK_TEXT_COLOR_LIGHT)
                Spacer(minLength: 1)
            }.padding(.horizontal)
                .padding(.bottom, 32)

        }.onAppear(){
           
            retrieveDistance()

                region = building.coordinate
            
            if let coordinate = building.coordinate {
                position = MapCameraPosition.region(MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000))
            }
            region = building.coordinate
            
        }.tint(COLORS.BRAND_COLOR)
    
    }
    
    func retrieveDistance(){
        
        distanceInKmText = ""
        
        if distanceInKm == nil {
            if let targetLocation = building.coordinate {
                if locationManager.location != nil {
                    distanceInKm = locationManager.getDistanceInKm(targetLocation: targetLocation)
                    updateDistanceText()
                } else {
                    // Request location if not available
                    locationManager.retrieveLocation()
                }
            }
        } else {
            updateDistanceText()
        }
    }
    
    func updateDistanceText(){
        if let distanceInKm {
            distanceInKmText = localizedString(forKey: "Building_Distance_From_You", parameters: String(distanceInKm))
        }else{
            distanceInKmText = ""
        }
        
    }
}

