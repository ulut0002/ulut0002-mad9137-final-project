//
//  BuildingView.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-12-05.
//

import SwiftUI
import MapKit

struct BuildingView: View {
    @Binding var building: Building
    @ObservedObject var appModel: AppModel
    @State var featureList: [Feature] = []
    @State var masterFeatureList: [Feature] = []

    

    

    private func buildFeatureList(){
        
        if masterFeatureList.count > CONFIGURATION.BUILDING_AMENITIES_SHORT_LENGTH{
            if (appModel.buildingDetailShowAllAmenities){
                featureList = masterFeatureList
            }else{
                featureList = Array(masterFeatureList[...CONFIGURATION.BUILDING_AMENITIES_SHORT_LENGTH])
            }
        }else{
            featureList = masterFeatureList

        }
    }
    
    
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(spacing: 8){
                    Image(building.imageResourceName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 0))
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
                                    .cornerRadius(0)
                                }
                                Spacer()
                            }
                        }
                    
                    VStack{
                        
                        
                        HStack(){
                            Text(building.name ?? "")
                                .multilineTextAlignment(.leading)
                                .lineLimit(nil)
                            Spacer()
                        }.padding(.horizontal)
                        HStack{
                            let cat = BuildingCategory.resolveCategory(categoryId: building.categoryId ?? -1)
                            Image(systemName:cat.imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: CONFIGURATION.BUILDING_VIEW_ICON_WIDTH, height: CONFIGURATION.BUILDING_VIEW_ICON_HEIGHT)
                            Text(cat.translation)
                            Spacer()
                        }.padding(.horizontal)
                        Divider()
                        
                        VStack{
                            HStack{
                                if let description = building.description {
                                    Text(appModel.buildingDetailShowAllDescription ? description : description.cropText())
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(nil)
                                }else{
                                    Text(LocalizedStringKey("Building_View_Awaiting_Description"))
                                }
                            }
                            
                            HStack{
                                Spacer()
                                Button(action: {
                                    appModel.toggleBuildingDetailShowLongDescription()
                                }, label: {
                                    Text(appModel.buildingDetailShowAllDescription ? LocalizedStringKey("Building_View_Button_Show_Less"):LocalizedStringKey("Building_View_Button_Show_More"))
                                })
                                
                            }
                        }.padding(.horizontal)
                        
                        Divider()
                        
                        VStack{
                            Text(LocalizedStringKey("Building_View_Title_Amenities"))
                            
                            ForEach(featureList){ val in
                                HStack{
                                    Image(systemName:val.option.imageName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: CONFIGURATION.BUILDING_VIEW_ICON_WIDTH, height: CONFIGURATION.BUILDING_VIEW_ICON_HEIGHT)
                                    Text(val.option.translation)
                                    Spacer()
                                }
                            }
                            
                            if featureList.count > CONFIGURATION.BUILDING_AMENITIES_SHORT_LENGTH{
                                HStack{
                                    Spacer()
                                    Button(action: {
                                        appModel.toggleBuildingDetailShowAllAmenities()
                                    }, label: {
                                        Text(appModel.buildingDetailShowAllAmenities ? LocalizedStringKey("Building_View_Button_Show_Less"):LocalizedStringKey("Building_View_Button_Show_More"))
                                    })
                                }
                            }
                            
                            
                            
                            
                        }.padding(.horizontal)
                        
                        Divider()
                        
                        Text(LocalizedStringKey("Building_View_Title_Location"))
                        
                        BuildingViewMap(building: building).frame(width: 400, height: 300, alignment: .center)
                          
                        
                       

                    }
                    
                    
                    
                    
                    //                Spacer()
                }.background(.white)
                    .background(Color.white)
                    .cornerRadius(0)
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 4, y: 4)
                //            .padding(8)
                
                
                
                
                
            }
            //https://stackoverflow.com/questions/59137040/ios-swiftui-scrollview-ignore-top-safe-area
            .padding(.top, 1)
               
        }
        .onAppear(){
            
            
            for feature in appModel.buildingAmenities {
                if (building.hasFeature(feature: feature)){
                    masterFeatureList.append(Feature(option: feature, selected: true))
                }
                buildFeatureList()
            }
            
            
           
            
        }.onChange(of: appModel.buildingDetailShowAllAmenities){
            buildFeatureList()
        } 
        .navigationBarTitle(Text(building.name ?? ""), displayMode: .automatic).multilineTextAlignment(.center).lineLimit(3)
       
       

        
        
        
    }
}

