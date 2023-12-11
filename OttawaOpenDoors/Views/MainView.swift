//
//  MainView.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-22.
//

import SwiftUI
import MapKit

struct MainView: View {
    @StateObject var appModel:AppModel
    @State var isSheetPresented = false
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var locationManager:LocationManager
    @EnvironmentObject var appLanguageManager:AppLanguageManager
    
    @State private var labelResultFound:String = ""
    @State private var labelContentNotAvailableText:String = ""
    @State private var labelContentNotAvailableDescription:String = ""
    
    
    
    var body: some View {
        
        NavigationView{
           VStack(alignment: .leading){
                if (appModel.fetchStatus == .fetching){
                    VStack(alignment: .center){
                        ProgressView()
                    }
                }
                
                if (appModel.fetchStatus == .error){
                    VStack(alignment: .center){
                        ContentUnavailableView{
                            Label(labelContentNotAvailableText, systemImage: "network.slash")
                        }description:{
                            Text(labelContentNotAvailableDescription)
                        }
                    }
                }
                
                if (appModel.fetchStatus == .idle){
                    
                    ScrollView{
                        HStack{
                            Spacer()
                            
                            Text(labelResultFound).foregroundStyle(COLORS.DARK_TEXT_COLOR)
                                .font(.subheadline)
                            
                            
                            Spacer()
                        }.padding(.vertical, 8)
                        
                        
                        LazyVStack(spacing: 12){
                            ForEach(Array(appModel.filteredBuildings.enumerated()), id: \.element.id){ index, building in
                                BuildingCard(building: $appModel.filteredBuildings[index],
                                             appModel: appModel,
                                             index: index
                                ).padding(.horizontal, 8)
                                
                            }
                        }
                    }
                    Spacer()
                }
                
            }
            .background(COLORS.BACKGROUND_COLOR)
            .toolbarBackground(.visible, for: .navigationBar, .tabBar)
            .toolbarBackground(COLORS.TOOLBAR_COLOR)
            
            .toolbar {
                ToolbarItem(placement: .topBarLeading){
                    Toolbar(title: "Toolbar_Title")
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Label(
                        title: { Text("") },
                        icon: { Image(systemName: "magnifyingglass")
                        }
                    )
                    .foregroundStyle(COLORS.LIGHT_TEXT_COLOR)
                    .labelsHidden()
                    .onTapGesture {
                        isSheetPresented.toggle()
                    }
                }
            }
            .sheet(isPresented: $isSheetPresented, content: {
                SearchFiltersView(appModel: appModel, filterSource: .main, isSheetPresented: $isSheetPresented)
                
            }).onChange(of: appModel.filteredBuildings, {
                
            })
            
        }
        .tint(COLORS.LIGHT_TEXT_COLOR)
        .onAppear(){
            setLabels()
        }.onChange(of: appModel.userConfig.preferredLanguage, {
            setLabels()
        }).onChange(of: appModel.filteredBuildings, {
            setLabels()
        })
        
    }
    
    
    private func setLabels(){
        let locale = appLanguageManager.locale.identifier
        labelResultFound = "Search_Results_Count".localizeString(string: locale, parameters: $appModel.filteredBuildings.count)
    
        labelContentNotAvailableText = "Content_Not_Available_Text".localizeString(string: locale)
        
        labelContentNotAvailableDescription = "Content_Not_Available_Description".localizeString(string: locale)
        
    }
    
    
    
    
}
