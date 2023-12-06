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

    
    var body: some View {
        NavigationLink(destination: BuildingView(building: $building,
                                                 appModel: appModel)){
            
            
            VStack(spacing: 8){
                Image(building.imageResourceName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .overlay{
                        VStack(alignment: .trailing){
                            HStack {
                                Spacer()
                                HStack{
                                    Image(systemName: "square.and.arrow.up")
                                        .opacity(1)
                                        .foregroundStyle(COLORS.FAV_OVERLAY_STROKE_COLOR)
                                        .padding(.trailing, 8)
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
                        Text(building.name ?? "No Name").font(.body).bold()
                        Spacer()
                    }
                    HStack{
                        Text(building.address ?? "").font(.caption2)
                        Spacer()
                        Text("3.4 km from you").font(.caption2)
                    }.padding(.vertical, 1)
                }
                
            }.background(.white)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.2), radius: 5, x: 4, y: 4)
            //            .padding(8)
            
            
            
            
            
        }
    }
}

