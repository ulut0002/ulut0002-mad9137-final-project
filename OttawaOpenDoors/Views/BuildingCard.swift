//
//  BuildingCard.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-12-03.
//

import SwiftUI

struct BuildingCard: View {
    @Binding var building:Building
    @ObservedObject var appModel: AppModel
    var index: Int
    @State var distanceInKm : Double? = nil
    @State var distanceInKmText = ""
    @EnvironmentObject var locationManager:LocationManager
    
    
    var body: some View {
        NavigationLink(destination: BuildingView(building: $building,
                                                 appModel: appModel)){
            
            
            
            
            VStack(spacing: 8){
                
                Image(building.imageResourceName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(UnevenRoundedRectangle(
                        topLeadingRadius:STYLE_VARIABLES.CARD_VIEW_DEFAULT_CORDER_RADIUS,
                        bottomLeadingRadius: 0.0,
                        bottomTrailingRadius: 0.0,
                        topTrailingRadius: STYLE_VARIABLES.CARD_VIEW_DEFAULT_CORDER_RADIUS,
                        style: .continuous)
                    )
                    .overlay{
                        VStack(alignment: .trailing){
                            HStack {
                                Spacer()
                                HStack{
                                    OODShareLink(building: building)

                                    Image(systemName: building.bookmarkInfo == nil ? "bookmark":"bookmark.fill")
                                        .opacity(1)
                                        .foregroundStyle(COLORS.FAV_OVERLAY_STROKE_COLOR)
                                        .shadow(radius:1)
                                        .onTapGesture {
                                            appModel.toggleBookmark(building: building)
                                        }
                                    
                                }
                                .padding(.all, 12)
                                .background(COLORS.FAV_OVERLAY_BG_COLOR)
                                .cornerRadius(2)
                            }
                            Spacer()
                        }
                    }
                
                
                // mame and address
                VStack{
                    HStack{
                        Text(building.name ?? "No Name")
                            .font(.headline)
                            .bold()
                            .foregroundStyle(COLORS.DARK_TEXT_COLOR)
                            .multilineTextAlignment(.leading)
                        Spacer(minLength: 40)
                    }
                    HStack{
                        
                        Text(building.address ?? "")
                            .font(.caption2)
                            .foregroundStyle(COLORS.DARK_TEXT_COLOR_LIGHT)
                            .multilineTextAlignment(.leading)
                        Spacer(minLength: 80)
                        Text(distanceInKmText)
                            .font(.caption2)
                            .foregroundStyle(COLORS.DARK_TEXT_COLOR_LIGHT)
                    }.padding(.vertical, 1)
                }.padding(.vertical, 8)
                    .padding(.horizontal, 6)
                
            }.background(.white)
                .background(Color.white)
                .cornerRadius(STYLE_VARIABLES.CARD_VIEW_DEFAULT_CORDER_RADIUS)
                .shadow(color: STYLE_VARIABLES.CARD_VIEW_DEFAULT_SHADOW_COLOR,
                        radius: STYLE_VARIABLES.CARD_VIEW_DEFAULT_SHADOW_RADIUS,
                        x: STYLE_VARIABLES.CARD_VIEW_DEFAULT_SHADOW_X,
                        y: STYLE_VARIABLES.CARD_VIEW_DEFAULT_SHADOW_Y
                )
        }.onAppear(){
            retrieveDistance()
            
        }.onChange(of: locationManager.locationAuthorizationStatus, {
            retrieveDistance()
        })
        
    }
    
    
    func retrieveDistance(){
        
        distanceInKmText = ""
        
        if distanceInKm == nil {
            if let targetLocation = building.coordinate {
                if locationManager.location != nil {
                    if let distance = locationManager.getDistance(targetLocation: targetLocation){
                        building.distanceFromUserLocation = distance
                    }
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




