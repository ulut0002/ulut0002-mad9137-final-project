//
//  SavedView.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-22.
//

import SwiftUI

struct SavedView: View {
    @StateObject var appModel: AppModel
    @EnvironmentObject var appLanguageManager: AppLanguageManager
    
    @State var isSheetPresented = false


    //Favorites_Count_Plural
    //Favorites_Count_Zero
    // Favorites_Count_Single
    var body: some View {
        NavigationView{
            
            VStack(alignment: .leading){
                
                if (appModel.fetchStatus == .fetching){
                    ProgressView()
                }
                
                if (appModel.fetchStatus == .idle){
                    HStack{
                        Spacer()
                        if appModel.filteredFavorites.count > 0 {
                            Text("Favorites_Count_Plural".localizeString(string: appLanguageManager.locale.identifier, parameters: appModel.filteredFavorites.count))
                                .font(.subheadline)
                        }else{
                            Spacer()
                            VStack(alignment: .center){
                                Text("Favorites_Count_Zero".localizeString(string: appLanguageManager.locale.identifier))
                                    .font(.subheadline)
                                
                                Image("placeHolderLogoFaded").resizable().aspectRatio(contentMode: .fit).frame(width: 200,height: 300)
                            }
                            Spacer()
                        }
                        Spacer()
                    }.padding(.vertical, 8)
                    
                    if (appModel.filteredFavorites.count > 0){
                        ScrollView{
                            LazyVStack(spacing: 12){
                                ForEach(Array(appModel.filteredFavorites.enumerated()), id: \.element.id){ index, building in
                                    BuildingCard(building: $appModel.filteredFavorites[index], 
                                                 appModel : appModel,
                                                 index: index).padding(.horizontal, 8)
                                    
                                }
                            }
                        }
                    }
                }
                
            }
            
            .toolbarBackground(COLORS.TOOLBAR_COLOR)
            .toolbarBackground(.visible, for: .navigationBar, .tabBar)
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading){
                    Toolbar(title: "Toolbar_Title_Favorites")
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
            } .sheet(isPresented: $isSheetPresented, content: {
                SearchFiltersView(appModel: appModel, filterSource: .bookmarks, isSheetPresented: $isSheetPresented)
                
            })
            
            
        }.tint(COLORS.LIGHT_TEXT_COLOR)
    }
}
