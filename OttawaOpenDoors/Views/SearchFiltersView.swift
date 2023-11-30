//
//  SearchFiltersView.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-29.
//

import SwiftUI

struct SearchFiltersView: View {
    @ObservedObject var appModel: AppModel
    @Binding var isSheetPresented: Bool
    
    var body: some View {
        
        ZStack{
            Color.clear.edgesIgnoringSafeArea(.all)
            VStack{
                Text(LocalizedStringKey("Search_Filters_Title")).font(.headline)
                
                Text(LocalizedStringKey("Search_Filters_Search_Title")).font(.subheadline)
                SearchField(searchText: $appModel.draftUserFilters.keyword)
                
                
                Text(LocalizedStringKey("Search_Filters_Sort_Title")).font(.subheadline)

                Picker("What is your favorite color?", selection: $appModel.draftUserFilters.sortBy) {
                    Text("Name").tag(SortBy.alphabetical_asc)
                    Text("Distance").tag(SortBy.distance_asc)
                        }
                        .pickerStyle(.segmented)
                
                
                Text(LocalizedStringKey("Search_Filters_Features_Title")).font(.subheadline)
                
                
                
                Text(LocalizedStringKey("Search_Filters_Categories_Title")).font(.subheadline)
                
                Spacer()


            }

         

        }.onAppear{
            appModel.draftUserFilters = appModel.userFilters
           
        }
    }
}


struct SearchFiltersView_Previews: PreviewProvider {
    static var previews: some View {
        let appModel = AppModel()
        SearchFiltersView(appModel: appModel, isSheetPresented: .constant(true))

    }
}
