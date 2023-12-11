//
//  BuildingMapPreview.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-12-11.
//

import SwiftUI

struct BuildingMapPreview: View {
    @ObservedObject var appModel: AppModel
    @Binding var building: Building
    var clearSelectedBuilding: ()  -> Void


    
    
    
    @EnvironmentObject var appLanguageManager: AppLanguageManager
    @EnvironmentObject var locationManager:LocationManager

    
    // we need image, name and distance
    var body: some View {
        
       
            
            ZStack{
                Color.white.opacity(1)
                
                
                
                
                // Building image
                
                
                
                
                VStack{
                   
                    Image(building.imageResourceName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 300, height: 200)
                    
                        .clipShape(RoundedRectangle(cornerRadius: 0))
                    
                        .overlay{
                            VStack(alignment: .trailing){
                                HStack {
                                    
                                    Spacer()
                                    HStack(alignment: .firstTextBaseline, spacing: 12){
                                        OODShareLink(building: building)

                                        Image(systemName: building.bookmarkInfo == nil ? "bookmark":"bookmark.fill")
                                            .opacity(1)
                                            .foregroundStyle(COLORS.FAV_OVERLAY_STROKE_COLOR)
                                            .onTapGesture {
                                                appModel.toggleBookmark(building: building)
                                            }
                                        
                                        Image(systemName: "xmark")
                                            .opacity(1)
                                            .foregroundStyle(COLORS.FAV_OVERLAY_STROKE_COLOR)
                                            .onTapGesture(perform: {
                                                clearSelectedBuilding()
                                            })
                                        
                                        
                                        
                                        
                                    }
                                    .padding(.all, 12)
                                    .background(COLORS.FAV_OVERLAY_BG_COLOR)
                                    .cornerRadius(0)
                                }
                                Spacer()
                            }
                        }
                    
                    HStack(){
                        Text(building.name ?? "")
                            .multilineTextAlignment(.leading)
                            .lineLimit(nil)
                            .font(.caption)
                            .bold()
                            .foregroundStyle(COLORS.DARK_TEXT_COLOR)
                    }
                }
            }.background(Color.clear) // Adjust opacity as needed
                .frame(width: 300, height: 200)
        }
        
    
}
