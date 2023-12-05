//
//  MapView.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-22.
//

import SwiftUI
import MapKit

struct MapView: View {
    @ObservedObject var appModel:AppModel
    @State var text = "Text1"
    @State private var position : MapCameraPosition = .automatic
    @State private var searchResults: [MKMapItem] = []
    @State private var visibleRegion : MKCoordinateRegion?
    

    @State private var region = MKCoordinateRegion(center:
            CLLocationCoordinate2D(latitude: OttawaCoordinates.lat.rawValue, longitude: OttawaCoordinates.long.rawValue),
            span: MKCoordinateSpan(latitudeDelta: 0.06, longitudeDelta: 0.06))
//    
    
    var body: some View {
        VStack{
         
            VStack(){
                Map(position: $position){
                    
                    ForEach(appModel.filteredBuildings, id:\.self){ building in
                      
//
//                        if let latitude = building.latitude, let longitude = building.longitute {
//                            Marker(building.name, coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
//                            
//                        }
                        
                    }
                    //                    Marker("Parking",systemImage,coordinate: CLLocationCoordinate2D), or use Marker(item: MKMapItem)
                    
                    /**
                     
                        marker color: Marker.tint(.orange)
                     
                     */
                     
                    
//                    Annotation("Name", coordinate: <#T##CLLocationCoordinate2D#>){
//                        ZStack{
//                            // put what you want here. This is the the view when you click on it.
//                        }
//                    }

                }
            }
            .mapStyle(.standard(elevation: .realistic))
            .onTapGesture {
                text = "Text 2"
            }
            .onChange(of: searchResults){
                position = .automatic
            }
            .onMapCameraChange { context in
                visibleRegion = context.region
            }
            .safeAreaInset(edge: .bottom){
                HStack{
                    Text(text)
                }
            }
            .mapControls{
                MapUserLocationButton()
                MapCompass()
                MapScaleView()
            }
            
   
        }.onAppear(){
            appModel.userLocation.checkIfLocationServicesIsEnabled()
        }
    }
}

#Preview {
    MapView(appModel: AppModel())
}



/**
 
 
 */
