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
    
    @State var buildingDescription = ""
    
    @State var sundayHours = ""
    @State var saturdayHours = ""
    
    
    
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
                    
                    
                    
                    // Building image
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
                    
                    
                    // Building name
                    HStack(){
                        Text(building.name ?? "")
                            .multilineTextAlignment(.leading)
                            .lineLimit(nil)
                            .font(.title2)
                            .bold()
                            .foregroundStyle(COLORS.DARK_TEXT_COLOR)
                        Spacer(minLength: 40)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 16)
                    Divider()
                    
                    
                    
                    // Building Category
                    HStack{
                        let cat = BuildingCategory.resolveCategory(categoryId: building.categoryId ?? -1)
                        Image(systemName:cat.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: CONFIGURATION.BUILDING_VIEW_ICON_WIDTH, height: CONFIGURATION.BUILDING_VIEW_ICON_HEIGHT)
                            .foregroundStyle(COLORS.DARK_TEXT_COLOR)
                        
                        Text(cat.translation)
                            .foregroundStyle(COLORS.DARK_TEXT_COLOR)
                            .font(.body)
                        Spacer()
                    }.padding(.horizontal, 16)
                        .padding(.vertical, 16)
                    Divider()
                    
                    
                    // Opening hours
                    
                    VStack{
                        HStack{
                            Text(LocalizedStringKey("Building_View_Opening_Hours"))
                                .foregroundStyle(COLORS.DARK_TEXT_COLOR)
                                .font(.headline)
                            
                            Spacer(minLength: 1)
                        }.padding(.bottom, 8)
                        
                        VStack{
                            if (!saturdayHours.isEmpty){
                                HStack{
                                    Text(saturdayHours)
                                        .foregroundStyle(COLORS.DARK_TEXT_COLOR)
                                        .font(.body)
                                    Spacer(minLength: 1)
                                }
                            }
                            
                            if (!sundayHours.isEmpty){
                                HStack{
                                    Text(sundayHours)
                                        .foregroundStyle(COLORS.DARK_TEXT_COLOR)
                                        .font(.body)
                                    Spacer(minLength: 1)
                                }
                            }
                            
                        }
                    }.padding(.horizontal)
                        .padding(.vertical, 16)
                    
                    Divider()
                    
                    //
                    
                    
                    // Building Description
                    HStack{
                        if (!buildingDescription.isEmpty) {
                            
                            Text(buildingDescription)
                                .foregroundStyle(COLORS.DARK_TEXT_COLOR)
                                .font(.body)
                                .padding(0)
                                .lineSpacing(10)
                        }else{
                            Text(LocalizedStringKey("Building_View_Awaiting_Description"))
                                .foregroundStyle(COLORS.DARK_TEXT_COLOR)
                                .font(.body)
                                .padding(0)
                            
                        }
                        Spacer(minLength: 1)
                    }.padding(.horizontal)
                        .padding(.vertical, 16)
                    
                    
                    // Building description more or less button
                    
                    HStack{
                        Spacer(minLength: 1)
                        Button(action: {
                            appModel.toggleBuildingDetailShowLongDescription()
                        }, label: {
                            Text(appModel.buildingDetailShowAllDescription ? LocalizedStringKey("Building_View_Button_Show_Less"):LocalizedStringKey("Building_View_Button_Show_More"))
                                .foregroundStyle(COLORS.TEXT_BUTTON_BLUE)
                                .font(.caption)
                        })
                        
                    }
                    .padding(.horizontal, 16)
                    
                    Divider()
                    
                    
                    HStack{
                        Text(LocalizedStringKey("Building_View_Title_Amenities"))
                            .foregroundStyle(COLORS.DARK_TEXT_COLOR)
                            .font(.headline)
                        
                        Spacer(minLength: 1)
                    }.padding(.horizontal)
                    
                    
                    if (appModel.buildingDetailShowAllAmenities ){
                        VStack(spacing: 16){
                            ForEach(featureList){ val in
                                HStack{
                                    Image(systemName:val.option.imageName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: CONFIGURATION.BUILDING_VIEW_ICON_WIDTH, height: CONFIGURATION.BUILDING_VIEW_ICON_HEIGHT)
                                        .foregroundStyle(COLORS.DARK_TEXT_COLOR)
                                    Text(val.option.translation)
                                        .foregroundStyle(COLORS.DARK_TEXT_COLOR)
                                        .font(.body)
                                    Spacer(minLength: 1)
                                }
                            }
                        }.padding(.horizontal)
                            .padding(.vertical, 16)
                    }else {
                        HStack(spacing: 8){
                            ForEach(featureList){ val in
                                HStack{
                                    Spacer()
                                    Image(systemName:val.option.imageName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: CONFIGURATION.BUILDING_VIEW_ICON_WIDTH, height: CONFIGURATION.BUILDING_VIEW_ICON_HEIGHT)
                                        .foregroundStyle(COLORS.DARK_TEXT_COLOR)
                                    
                                    
                                    Spacer()
                                }
                            }
                        }.padding(.horizontal)
                            .padding(.vertical, 16)
                    }
                    
                    VStack{
                        if featureList.count > CONFIGURATION.BUILDING_AMENITIES_SHORT_LENGTH{
                            HStack{
                                Spacer()
                                Button(action: {
                                    appModel.toggleBuildingDetailShowAllAmenities()
                                }, label: {
                                    Text(appModel.buildingDetailShowAllAmenities ? LocalizedStringKey("Building_View_Button_Show_Less"):LocalizedStringKey("Building_View_Button_Show_More"))
                                        .foregroundStyle(COLORS.TEXT_BUTTON_BLUE)
                                    
                                        .font(.caption)
                                })
                            }
                        }
                    }.padding(.horizontal)
                        .padding(.vertical, 16)
                    
                    Divider()
                    
                    HStack{
                        Text(LocalizedStringKey("Building_View_Title_Location"))
                            .foregroundStyle(COLORS.DARK_TEXT_COLOR)
                            .font(.headline)
                        Spacer(minLength: 1)
                    }.padding(.horizontal)
                    
                    
                    
                    BuildingViewMap(building: building).frame(width: 400, height: 300, alignment: .center)
                    
                    
                    
                }.background(.white)
                    .background(Color.white)
                    .cornerRadius(0)
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 4, y: 4)
                //            .padding(8)
                
                
                
                
                
            }
            //https://stackoverflow.com/questions/59137040/ios-swiftui-scrollview-ignore-top-safe-area
            .padding(.top, 1)
            .padding(.bottom, 1)
            
            
            
        }
        .onAppear(){
            
            
            
            for feature in appModel.buildingAmenities {
                if (building.hasFeature(feature: feature)){
                    masterFeatureList.append(Feature(option: feature, selected: true))
                }
                buildFeatureList()
            }
            formatBuildingText()
            
            
            if let saturdayStart = building.saturdayStart, let saturdayClose = building.saturdayClose {
                saturdayHours = formatDate(saturdayStart, saturdayClose, locale: appModel.locale) ?? ""
            }
            
            if let sundayStart = building.sundayStart, let sundayClose = building.sundayClose{
                sundayHours = formatDate(sundayStart, sundayClose, locale: appModel.locale) ?? ""
                
                
            }
            
            
        }.onChange(of: appModel.buildingDetailShowAllAmenities){
            buildFeatureList()
        }.onChange(of: appModel.buildingDetailShowAllDescription){
            formatBuildingText()
        }
        .background(COLORS.BACKGROUND_COLOR)
        //        .background(.yellow)
        .toolbarBackground(.visible, for: .navigationBar, .tabBar)
        .toolbarBackground(COLORS.TOOLBAR_COLOR)
        .toolbar {
            ToolbarItem(placement: .principal){
                Text(building.name ?? "").multilineTextAlignment(.center).lineLimit(3)
                    .foregroundStyle(COLORS.LIGHT_TEXT_COLOR)
            }
            
            
        }
        
        
        
        
    }
    
    func formatBuildingText(){
        if let description = building.description {
            if (appModel.buildingDetailShowAllDescription){
                buildingDescription = description
            }else{
                buildingDescription = description.cropText()
            }
        }else {
            buildingDescription = ""
        }
        
    }
}

