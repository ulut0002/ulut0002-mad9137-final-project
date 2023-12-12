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
    
    @State private var selectedBuilding: Building?
    @State private var selectedBuildingIndex: Int?
    
    func clearSelectedBuilding(){
        self.selectedBuilding = nil
        self.selectedBuildingIndex = nil
    }
    
    //
    @State private var route: MKRoute?
    @Environment(\.colorScheme) var colorScheme
    
    @State var markerBgColor: Color = COLORS.MAP_MARKER_BG_COLOR_LIGHT_MODE
    @State var markerIconColor: Color = COLORS.MAP_MARKER_ICON_COLOR_DARK_MODE

    
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
    
    
    func isBuildingSelected(building: Building?) -> Bool {
        if let building = building {
            if let selectedBld = self.selectedBuilding, selectedBld.id == building.id {
                return true
            }
        }
        return false
    }
    
    
    func setColors(){
        switch colorScheme {
        case .dark:
            markerBgColor   = COLORS.MAP_MARKER_BG_COLOR_DARK_MODE
            markerIconColor = COLORS.MAP_MARKER_ICON_COLOR_DARK_MODE
            break
        case .light:
            markerBgColor   = COLORS.MAP_MARKER_BG_COLOR_LIGHT_MODE
            markerIconColor = COLORS.MAP_MARKER_ICON_COLOR_LIGHT_MODE
            break;
        
        @unknown default:
            markerBgColor   = COLORS.MAP_MARKER_BG_COLOR_LIGHT_MODE
            markerIconColor = COLORS.MAP_MARKER_ICON_COLOR_LIGHT_MODE
            break;
        }
    }
    
    var body: some View {
        
        ZStack (alignment: .bottom) {
            VStack(){
                Map(position: $position, selection: $selectedTag){
//                    ForEach(appModel.filteredBuildings.prefix(3)){building in
                
                    ForEach(Array(appModel.filteredBuildings.enumerated()), id: \.element){index, building in

                        if let coordinate = building.coordinate, let name = building.name{
                           
                            Annotation(name, coordinate: coordinate){
                                ZStack{
                                    RoundedRectangle(cornerRadius: 105, style: .circular).fill(markerBgColor)
                                    RoundedRectangle(cornerRadius: 105, style: .circular).stroke(.secondary, lineWidth: 2)
                                    
                                    if let selectedBld = self.selectedBuilding, selectedBld.id == building.id {
                                        Image(systemName: building.systemImage).resizable().aspectRatio(contentMode: .fit).frame(width: 36, height: 36, alignment: .center)
                                            .foregroundStyle(markerIconColor)
                                    }else{
                                        Image(systemName: building.systemImage).resizable().aspectRatio(contentMode: .fit).frame(width: 24, height: 24, alignment: .center)
                                            .foregroundStyle(markerIconColor)
                                    }
                                   
                                    
                                }.onTapGesture{
                                    self.selectedBuilding = building
                                    self.selectedBuildingIndex = index
                                    text = building.name ?? "Unkown"
//

                                    
                                }.frame(width: selectedBuilding?.id == building.id ? 48 : 32, height: selectedBuilding?.id == building.id ? 48 : 32)

                            }.annotationTitles(.hidden)
                                
//
                            
                        }
                    }
                    UserAnnotation()
                }
                .onTapGesture(perform: {
//                    self.selectedBuilding = nil
                })
                .mapStyle(.standard(elevation: .realistic))
                .mapControls{
                    MapUserLocationButton()
                    MapCompass()
                    MapScaleView()
                    MapPitchToggle()
                

                }
                .mapControlVisibility(.visible)
                .onChange(of: appModel.filteredBuildings){
//                    position = .automatic
                }
                .onMapCameraChange { context in
                    visibleRegion = context.region
                }

                
            }
            .onAppear(){

                setColors()
            }.onChange(of: self.colorScheme, {
                setColors()
            })
            
            if let _ = selectedBuilding, let index = selectedBuildingIndex {
                BuildingMapPreview(appModel: appModel, building: $appModel.filteredBuildings[index],
                                   clearSelectedBuilding: clearSelectedBuilding)
                    .padding(.bottom, 48)
                
            

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
