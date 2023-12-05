//
//  FeatureFilter.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-12-01.
//

import SwiftUI

struct FeatureFilter: View {
    @ObservedObject var appModel: AppModel

    var body: some View {
        VStack{
            Text(LocalizedStringKey("Search_Filters_Features_Title")).font(.headline)
            FeatureFilterItem(draftFeature: $appModel.draftUserFilters.features.familyFriendly)
            FeatureFilterItem(draftFeature: $appModel.draftUserFilters.features.accessible)
            FeatureFilterItem(draftFeature: $appModel.draftUserFilters.features.bikeParking)
            FeatureFilterItem(draftFeature: $appModel.draftUserFilters.features.freeParking)
            FeatureFilterItem(draftFeature: $appModel.draftUserFilters.features.paidParking)

            FeatureFilterItem(draftFeature: $appModel.draftUserFilters.features.guidedTour)
            FeatureFilterItem(draftFeature: $appModel.draftUserFilters.features.isNew)
            FeatureFilterItem(draftFeature: $appModel.draftUserFilters.features.oCTranspoNearby)
            FeatureFilterItem(draftFeature: $appModel.draftUserFilters.features.shuttleBus)
            FeatureFilterItem(draftFeature: $appModel.draftUserFilters.features.openSaturday)
            FeatureFilterItem(draftFeature: $appModel.draftUserFilters.features.openSunday)
            FeatureFilterItem(draftFeature: $appModel.draftUserFilters.features.publicWashroom)
        }.padding(8)
    }
}




struct FeatureFilter_Previews: PreviewProvider {
    static var previews: some View {
        FeatureFilter(appModel: AppModel())
    }
}
