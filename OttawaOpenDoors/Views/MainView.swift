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
    
    //var x = LocalizedStringResource
    
    
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
                            Label(localizedString(forKey: "Content_Not_Available_Text"), systemImage: "network.slash")
                        }description:{
                            Text(localizedString(forKey: "Content_Not_Available_Description"))
                        }
                    }
                }
                
                if (appModel.fetchStatus == .idle){
                    
                    ScrollView{
                        HStack{
                            Spacer()
                            
                            Text(String(format: NSLocalizedString("Search_Results_Count", comment: ""), $appModel.filteredBuildings.count)).foregroundStyle(COLORS.DARK_TEXT_COLOR)
                                .font(.subheadline)
                            //
                            
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
                    Toolbar()
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Label(
                        title: { Text("Search") },
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
                SearchFiltersView(appModel: appModel, isSheetPresented: $isSheetPresented)
            }).onChange(of: appModel.filteredBuildings, {
                
            })
            
        }.tint(COLORS.LIGHT_TEXT_COLOR)
        
    }
    
    
    
    struct MainView_Previews: PreviewProvider {
        static var previews: some View {
            MainView(appModel: AppModel())
                .environmentObject(LocationManager())
        }
    }
    
}
