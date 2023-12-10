//
//  SavedView.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-22.
//

import SwiftUI

struct SavedView: View {
    @StateObject var appModel: AppModel
    
    var body: some View {
        NavigationView{
            
            VStack(alignment: .leading){
                
                if (appModel.fetchStatus == .fetching){
                    ProgressView("Fetching...")
                }
                
                if (appModel.fetchStatus == .idle){
                    HStack{
                        Spacer()
                        Text("\($appModel.filteredFavorites.count) favorites found").font(.subheadline)
                        Spacer()
                    }.padding(.vertical, 8)
                    
                    ScrollView{
                        LazyVStack(spacing: 12){
                            ForEach(Array(appModel.filteredFavorites.enumerated()), id: \.element.id){ index, building in
                                BuildingCard(building: $appModel.filteredFavorites[index], 
                                             appModel : appModel,
                                             index: index).padding(.horizontal, 8)
                                
                            }
                        }
                    }
                    Spacer()
                }
                Spacer()
                
            }
            
            .toolbarBackground(.visible, for: .navigationBar, .tabBar)
            .toolbarBackground(COLORS.TOOLBAR_COLOR)
            .toolbarBackground(.visible, for: .navigationBar, .tabBar)
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading){
                    Toolbar()
                }
                
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Label(
//                        title: { Text("Search") },
//                        icon: { Image(systemName: "magnifyingglass")
//                        }
//                    )
//                }
            }
            
            
        }.tint(COLORS.LIGHT_TEXT_COLOR)
    }
}
