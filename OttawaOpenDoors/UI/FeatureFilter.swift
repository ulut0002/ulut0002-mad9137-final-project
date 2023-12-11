//
//  FeatureFilter.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-12-01.
//

import SwiftUI

struct FeatureFilter: View {
    @ObservedObject var appModel: AppModel
    var filterSource: SearchScreenSource

    @EnvironmentObject var appLanguageManager: AppLanguageManager


    var body: some View {
        VStack(spacing: 10){
            Text("Filters_View_Label_Building_Features".localizeString(string: appLanguageManager.locale.identifier)).font(.headline)
            FeatureFilterItem(draftFeature: filterSource == .bookmarks ? $appModel.draftFavoriteFilters.features.familyFriendly: $appModel.draftUserFilters.features.familyFriendly)
            FeatureFilterItem(draftFeature:filterSource == .bookmarks ? $appModel.draftFavoriteFilters.features.accessible:  $appModel.draftUserFilters.features.accessible)
            FeatureFilterItem(draftFeature: filterSource == .bookmarks ? $appModel.draftFavoriteFilters.features.bikeParking: $appModel.draftUserFilters.features.bikeParking)
            FeatureFilterItem(draftFeature: filterSource == .bookmarks ? $appModel.draftFavoriteFilters.features.freeParking: $appModel.draftUserFilters.features.freeParking)
            FeatureFilterItem(draftFeature: filterSource == .bookmarks ? $appModel.draftFavoriteFilters.features.paidParking :  $appModel.draftUserFilters.features.paidParking)

            FeatureFilterItem(draftFeature: filterSource == .bookmarks ? $appModel.draftFavoriteFilters.features.guidedTour: $appModel.draftUserFilters.features.guidedTour)
            FeatureFilterItem(draftFeature:filterSource == .bookmarks ? $appModel.draftFavoriteFilters.features.isNew :  $appModel.draftUserFilters.features.isNew)
            FeatureFilterItem(draftFeature:filterSource == .bookmarks ? $appModel.draftFavoriteFilters.features.oCTranspoNearby:  $appModel.draftUserFilters.features.oCTranspoNearby)
            FeatureFilterItem(draftFeature:filterSource == .bookmarks ?$appModel.draftFavoriteFilters.features.shuttleBus :  $appModel.draftUserFilters.features.shuttleBus)
            FeatureFilterItem(draftFeature:filterSource == .bookmarks ? $appModel.draftFavoriteFilters.features.openSaturday:  $appModel.draftUserFilters.features.openSaturday)
            FeatureFilterItem(draftFeature:filterSource == .bookmarks ? $appModel.draftFavoriteFilters.features.openSunday:  $appModel.draftUserFilters.features.openSunday)
            FeatureFilterItem(draftFeature: filterSource == .bookmarks ? $appModel.draftFavoriteFilters.features.publicWashroom: $appModel.draftUserFilters.features.publicWashroom)
        }.tint(COLORS.BRAND_COLOR)
    }
}




struct FeatureFilter_Previews: PreviewProvider {
    
    static var previews: some View {
        let appLanguageManager = AppLanguageManager()
        let location = LocationManager()
        FeatureFilter(appModel: AppModel(), filterSource: .main)
            .environmentObject(appLanguageManager)
            .environmentObject(location)
    }
}
