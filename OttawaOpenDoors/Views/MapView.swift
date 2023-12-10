//
//  MapView.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-22.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    
    @StateObject var appModel:AppModel
    @State var text = ""
    @State private var position : MapCameraPosition = .automatic
    @State private var visibleRegion : MKCoordinateRegion?
    @State private var selectedTag: Int?
    @State private var mapStyle:MapStyle? = nil
    
    @State private var index = -1
    @State private var region = MKCoordinateRegion(center:
                                                    CLLocationCoordinate2D(latitude: OttawaCoordinates.lat.rawValue, longitude: OttawaCoordinates.long.rawValue),
                                                   span: MKCoordinateSpan(latitudeDelta: 0.06, longitudeDelta: 0.06))
    
    //
    @State private var route: MKRoute?
    
    func getDirections(from: MKMapItem, to: MKMapItem) {
        route = nil
        let request = MKDirections.Request()
        request.source = from
        request.destination = to
        
        Task {
            let directions = MKDirections(request: request)
            let response = try? await directions.calculate()
            route = response?.routes.first
        }
    
    }
    
    
    var body: some View {
        
        ZStack (alignment: .bottom) {
            VStack(){
                Map(position: $position, selection: $selectedTag){
//                    ForEach(appModel.filteredBuildings.prefix(3)){building in
                
                    ForEach(Array(appModel.filteredBuildings.prefix(3).enumerated()), id: \.element){index, building in

                        if let coordinate = building.coordinate, let name = building.name{
                           
                            
                            Annotation(name, coordinate: coordinate){
                                ZStack{
                                    RoundedRectangle(cornerRadius: 105, style: .circular).fill(COLORS.BRAND_COLOR)
                                    RoundedRectangle(cornerRadius: 105, style: .circular).stroke(.secondary, lineWidth: 2)
                                    Image(systemName: building.systemImage).resizable().aspectRatio(contentMode: .fit).frame(width: 24, height: 24, alignment: .center)
                                        .foregroundStyle(Color.white)
                                    
                                }.onTapGesture{
                                    text = building.name ?? "Unkown"
//                                    position = .region(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)))
//                                    position = .camera(MapCamera(centerCoordinate: coordinate, distance: 980, heading: 242, pitch: 60))
//                                    position = .userLocation(fallback: .automatic)
//                                    position = .automatic
//                                    position = .
                                    
//                                    position = .camera(MapCamera(centerCoordinate: coordinate, distance: 2000, heading: 0, pitch: 0))
                                    
                                    
//                                    let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
//                                    withAnimation{
////                                        position = .region(region)
//                                    }
                                    
                                    position = .item(MKMapItem(placemark: MKPlacemark(coordinate: coordinate)))
                                    
//                                    position = .camera(MapCamera(centerCoordinate: coordinate, distance: visibleRegion?.distance ?? 2000,
//                                                                 pitch: visibleRegion?.pitch ?? 0, heading: visibleRegion?.heading ?? 0))

                                    
                                }.frame(width: 32, height: 32)
                            }.annotationTitles(.hidden)
                            if let route {
                                MapPolyline(route).stroke(.blue, lineWidth: 5)
                            }
                            
                        }
                    }
                    UserAnnotation()
                }
                .mapStyle(.standard(elevation: .realistic))
                .mapControls{
                    MapUserLocationButton()
                    MapCompass()
                    MapScaleView()
                    MapPitchToggle()
                

                }
                .mapControlVisibility(.visible)
                .onChange(of: appModel.filteredBuildings){
                    position = .automatic
                }
                .onMapCameraChange { context in
                    visibleRegion = context.region
                }

                
            }
            .onAppear(){
                
            }
            
            
            VStack{
                Text(text).font(.title).foregroundStyle(.blue)
            }
        }
        
    }
}



struct ButtonView : View {
    
    var body: some View {
        HStack {
            
        }
    }
}
