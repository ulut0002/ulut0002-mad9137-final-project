//
//  SearchFiltersView.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-29.
//

import SwiftUI

struct SearchFiltersView: View {
    
    @ObservedObject var appModel: AppModel
    var filterSource: SearchScreenSource
    @Binding var isSheetPresented: Bool
    
    @EnvironmentObject var appLanguageManager: AppLanguageManager
    
    
    
    private func getSelectedDraftFilter() -> Filters{
        if filterSource == .bookmarks {
            return appModel.draftFavoriteFilters
        }
        return appModel.draftUserFilters
    }

    
    @State var isExpanded = true
    
    var body: some View {
        
        VStack(spacing: 0){
            
            HStack{
                Button("Filters_View_Label_Cancel".localizeString(string: appLanguageManager.locale.identifier)){
                    isSheetPresented.toggle()
                }
                Spacer()
                if (filterSource == .bookmarks){
                    Text("Filters_View_Label_Bookmark_Filters".localizeString(string: appLanguageManager.locale.identifier)).font(.headline)

                }else{
                    Text("Filters_View_Label_Filters".localizeString(string: appLanguageManager.locale.identifier)).font(.headline)

                }
                Spacer()
                Button("Filters_View_Label_Reset".localizeString(string: appLanguageManager.locale.identifier)){
                    if filterSource == .bookmarks{
                        appModel.resetBookmarkFilters()
                    }else{
                        appModel.resetFilters()

                    }
                }
                
            }.padding()
                .background(COLORS.BRAND_COLOR)
                .foregroundStyle(.white)
            
            
            VStack(alignment: .leading){
                SearchField(searchText: filterSource == .bookmarks  ? $appModel.draftFavoriteFilters.keyword : $appModel.draftUserFilters.keyword,
                            searchTextHint: filterSource == .bookmarks ?   "Filters_View_Label_Search_Keyword_Bookmark":
                "Filters_View_Label_Search_Keyword")
            }.background(.gray.opacity(0.3))
            
            
            
            ScrollView {
                VStack{
                    
                    VStack{
                        HStack(){
                            Text("Filters_View_Label_SortBy".localizeString(string: appLanguageManager.locale.identifier)).font(.headline)
                            Spacer()
                        }
                        
                        HStack(spacing: 12){
                            Button{
                                if filterSource == .bookmarks {
                                    appModel.draftFavoriteFilters.sortBy = .alphabetical_asc

                                }else{
                                    appModel.draftUserFilters.sortBy = .alphabetical_asc

                                }
                            }label: {
                                HStack{
                                    Image(systemName: "checkmark").font(.system(size: 16)).opacity(getSelectedDraftFilter().sortBy == .distance_asc ? 0 : 1)
                                    Text("Filters_View_Label_Sort_By_Name".localizeString(string: appLanguageManager.locale.identifier))
                                        .font(.headline)
                                        .foregroundStyle(getSelectedDraftFilter().sortBy == .alphabetical_asc ? COLORS.BUTTON_ENABLED_TEXT_COLOR : COLORS.BUTTON_DISABLED_TEXT_COLOR)
                                }
                                .padding(12) // Add padding to increase the button size
                                .background(getSelectedDraftFilter().sortBy == .alphabetical_asc ? COLORS.BUTTON_ENABLED_BG_COLOR : COLORS.BUTTON_DISABLE_BG_COLOR)
                                .cornerRadius(STYLE_VARIABLES.SORT_BUTTON_CORNER_RADIUS) // Add rounded corners
                                .overlay(
                                    RoundedRectangle(cornerRadius: STYLE_VARIABLES.SORT_BUTTON_CORNER_RADIUS)
                                        .stroke(getSelectedDraftFilter().sortBy == .alphabetical_asc ? COLORS.BUTTON_ENABLED_BORDER_COLOR : COLORS.BUTTON_DISABLE_BORDER_COLOR, lineWidth: 2) // Add blue border
                                )
                            }
                            
                            Button{
                                //action
                                if filterSource == .bookmarks {
                                    appModel.draftFavoriteFilters.sortBy = .distance_asc
                                }else{
                                    appModel.draftUserFilters.sortBy = .distance_asc

                                }
                            }label: {
                                HStack{
                                    Image(systemName: "checkmark").font(.system(size: 16)).opacity(getSelectedDraftFilter().sortBy == .alphabetical_asc ? 0 : 1)
                                    
                                    Text("Filters_View_Label_Sort_By_Distance".localizeString(string: appLanguageManager.locale.identifier))
                                        .font(.headline)
                                        .foregroundStyle(getSelectedDraftFilter().sortBy == .distance_asc ? COLORS.BUTTON_ENABLED_TEXT_COLOR : COLORS.BUTTON_DISABLED_TEXT_COLOR)
                                    
                                } .padding(12) // Add padding to increase the button size
                                    .background(getSelectedDraftFilter().sortBy == .distance_asc ? COLORS.BUTTON_ENABLED_BG_COLOR : COLORS.BUTTON_DISABLE_BG_COLOR)
                                    .cornerRadius(STYLE_VARIABLES.SORT_BUTTON_CORNER_RADIUS) // Add rounded corners
                                    .overlay(
                                        RoundedRectangle(cornerRadius: STYLE_VARIABLES.SORT_BUTTON_CORNER_RADIUS)
                                            .stroke(getSelectedDraftFilter().sortBy == .distance_asc ? COLORS.BUTTON_ENABLED_BORDER_COLOR : COLORS.BUTTON_DISABLE_BORDER_COLOR, lineWidth: 2) // Add blue border
                                    )
                            }
                        }.tint(COLORS.BRAND_COLOR)
                        
                    }
                    
                    
                    
                    VStack{
                        
                        
                        Divider().padding(.vertical, 8)
                        
                        
                        FeatureFilter(appModel: appModel, filterSource: filterSource)
                        Divider().padding(.vertical, 8)
                        
                        CategoryFilter(appModel: appModel, filterSource: filterSource)
                        
                        Divider().padding(.vertical, 8)
                        
                        Spacer()
                        
                        
                        
                        
                    }
                }.padding()
            }
            HStack{
                Spacer()
                Button {
                    if filterSource == .bookmarks {
                        appModel.applyFavoriteFilters()
                    }else{
                        appModel.applyFilters()

                    }
                    isSheetPresented = false
                } label: {
                    Text("Filters_View_Label_ApplyFiltersButton".localizeString(string: appLanguageManager.locale.identifier))
                } .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                Spacer()
            }.padding(.top, 16)
                .background(.white)
            
            
            
            
            
            
            
        }.onAppear{
            if filterSource == .main {
                appModel.draftUserFilters = appModel.userFilters
            }else if filterSource == .bookmarks{
                appModel.draftFavoriteFilters = appModel.favoriteFilters
            }
            
        }
        //        .background(COLORS.BACKGROUND_COLOR)
    }
}


struct SearchFiltersView_Previews: PreviewProvider {
    static var previews: some View {
        let appLanguageManager = AppLanguageManager()
        let location = LocationManager()

        let appModel = AppModel()
        SearchFiltersView(appModel: appModel, filterSource: .bookmarks, isSheetPresented: .constant(true))
            .environmentObject(appLanguageManager)
            .environmentObject(location)

        
    }
}
