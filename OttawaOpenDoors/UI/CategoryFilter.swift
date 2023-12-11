//
//  CategoryFilter.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-12-01.
//
import Foundation
import SwiftUI

struct CategoryFilter: View {
    @ObservedObject var appModel: AppModel
    var filterSource: SearchScreenSource

    @EnvironmentObject var appLanguageManager: AppLanguageManager

    
    var body: some View {
        
        VStack(spacing: 10){

            Text("Filters_View_Label_Categories".localizeString(string: appLanguageManager.locale.identifier)).font(.headline)

            CategoryFilterItem(draftCategory: filterSource == .bookmarks ? $appModel.draftFavoriteFilters.categories.religious : $appModel.draftUserFilters.categories.religious)
        
            CategoryFilterItem(draftCategory: filterSource == .bookmarks ? $appModel.draftFavoriteFilters.categories.embassy: $appModel.draftUserFilters.categories.embassy)

            CategoryFilterItem(draftCategory: filterSource == .bookmarks ? $appModel.draftFavoriteFilters.categories.government : $appModel.draftUserFilters.categories.government)

            CategoryFilterItem(draftCategory: filterSource == .bookmarks ? $appModel.draftFavoriteFilters.categories.functionalBuilding: $appModel.draftUserFilters.categories.functionalBuilding)

            CategoryFilterItem(draftCategory: filterSource == .bookmarks ? $appModel.draftFavoriteFilters.categories.gallery : $appModel.draftUserFilters.categories.gallery)

            CategoryFilterItem(draftCategory: filterSource == .bookmarks ? $appModel.draftFavoriteFilters.categories.academic : $appModel.draftUserFilters.categories.academic)

            CategoryFilterItem(draftCategory: filterSource == .bookmarks ? $appModel.draftFavoriteFilters.categories.sports :  $appModel.draftUserFilters.categories.sports)

            CategoryFilterItem(draftCategory: filterSource == .bookmarks ? $appModel.draftFavoriteFilters.categories.communityCenter: $appModel.draftUserFilters.categories.communityCenter)

            CategoryFilterItem(draftCategory: filterSource == .bookmarks ? $appModel.draftFavoriteFilters.categories.business: $appModel.draftUserFilters.categories.business)

            CategoryFilterItem(draftCategory: filterSource == .bookmarks ? $appModel.draftFavoriteFilters.categories.museum: $appModel.draftUserFilters.categories.museum)

            CategoryFilterItem(draftCategory:filterSource == .bookmarks ?  $appModel.draftFavoriteFilters.categories.other : $appModel.draftUserFilters.categories.other
            )

           

 
        }.onAppear(){
        }.tint(COLORS.BRAND_COLOR)


        
        
    }
}

struct CategoryFilter_Previews: PreviewProvider {
   

    static var previews: some View { 
        let appLanguageManager = AppLanguageManager()
        let location = LocationManager()
        CategoryFilter(appModel: AppModel(), filterSource: .main)
            .environmentObject(appLanguageManager)
            .environmentObject(location)
    }
}
