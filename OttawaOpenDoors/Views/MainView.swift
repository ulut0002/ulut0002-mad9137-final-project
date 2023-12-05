//
//  MainView.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-22.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var appModel:AppModel
    @State var isSheetPresented = false
    
    
    var body: some View {
        
        NavigationView{
            
            VStack(alignment: .leading){
                
                if (appModel.fetchStatus == .fetchingFirstTime){
                    ProgressView("Fetching...")
                }
                
                if (appModel.fetchStatus == .idle){
                    HStack{
                        Spacer()
                        Text("\($appModel.filteredBuildings.count) results found").font(.subheadline)
                        Spacer()
                    }.padding(.vertical, 8)
                    
                    ScrollView{
                        LazyVStack(spacing: 8){
                            ForEach(Array(appModel.filteredBuildings.enumerated()), id: \.element.id){ index, building in
                                BuildingCard(building: $appModel.filteredBuildings[index], index: index, toggleBookmark: appModel.toggleBookmark).padding(.horizontal, 8)
                                
                            }
                        }
                    }
                    Spacer()
                }
                
            }
            .background(COLORS.BACKGROUND_COLOR)
            
            .toolbarBackground(.visible, for: .navigationBar, .tabBar)
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading){
                    Toolbar()
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Label(
                        title: { Text("Search") },
                        icon: { Image(systemName: "magnifyingglass")
                        }
                    ).onTapGesture {
                        // TODO: open the search sheet
                        isSheetPresented.toggle()
                    }
                }
            }
            .sheet(isPresented: $isSheetPresented, content: {
                SearchFiltersView(appModel: appModel, isSheetPresented: $isSheetPresented)
            })
            
        }
        
        
        
        
        
    }
    
    
    
    struct MainView_Previews: PreviewProvider {
        static var previews: some View {
            MainView(appModel: AppModel())
        }
    }
    
}
