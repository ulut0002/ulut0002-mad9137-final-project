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
    
    var body: some View {
        
        VStack{
            Text(LocalizedStringKey("Search_Filters_Categories_Title")).font(.headline)

            CategoryFilterItem(draftCategory: $appModel.draftUserFilters.categories.religious)
        
            CategoryFilterItem(draftCategory: $appModel.draftUserFilters.categories.embassy)

            CategoryFilterItem(draftCategory: $appModel.draftUserFilters.categories.government)

            CategoryFilterItem(draftCategory: $appModel.draftUserFilters.categories.functionalBuilding)

            CategoryFilterItem(draftCategory: $appModel.draftUserFilters.categories.gallery)

            CategoryFilterItem(draftCategory: $appModel.draftUserFilters.categories.academic)

            CategoryFilterItem(draftCategory: $appModel.draftUserFilters.categories.sports)

            CategoryFilterItem(draftCategory: $appModel.draftUserFilters.categories.communityCenter)

            CategoryFilterItem(draftCategory: $appModel.draftUserFilters.categories.business)

            CategoryFilterItem(draftCategory: $appModel.draftUserFilters.categories.museum)

            CategoryFilterItem(draftCategory: $appModel.draftUserFilters.categories.other
            )

           

 
        }.onAppear(){
        }


        
        
    }
}

struct CategoryFilter_Previews: PreviewProvider {
    static var previews: some View {
        CategoryFilter(appModel: AppModel())
    }
}
