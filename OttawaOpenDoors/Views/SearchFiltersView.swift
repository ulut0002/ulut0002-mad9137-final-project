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
    
    @State var isExpanded = true
    
    var body: some View {
        
        VStack(spacing: 0){
            
            HStack{
                Button("Cancel"){
                    isSheetPresented.toggle()
                }
                Spacer()
                Text("Filters").font(.headline)
                Spacer()
                Button("Reset"){
                    appModel.resetFilters()
                }
                
            }.padding()
                .background(COLORS.BRAND_COLOR)
                .foregroundStyle(.white)
            
            
            VStack(alignment: .leading){
                SearchField(searchText: $appModel.draftUserFilters.keyword)
            }.background(.gray.opacity(0.3))
            
            ScrollView {
                
                VStack{
                    HStack(){
                        Text(LocalizedStringKey("Search_Filters_Sort_Title")).font(.headline)
                        Spacer()
                    }
                    
                    HStack(spacing: 12){
                        Button{
                            appModel.draftUserFilters.sortBy = .alphabetical_asc
                        }label: {
                            HStack{
                                Image(systemName: "checkmark").font(.system(size: 16)).opacity(appModel.draftUserFilters.sortBy == .distance_asc ? 0 : 1)
                                Text("By Name")
                                    .font(.headline)
                                    .foregroundStyle(appModel.draftUserFilters.sortBy == .alphabetical_asc ? COLORS.BUTTON_ENABLED_TEXT_COLOR : COLORS.BUTTON_DISABLED_TEXT_COLOR)
                            } .padding(12) // Add padding to increase the button size
                                .background(appModel.draftUserFilters.sortBy == .alphabetical_asc ? COLORS.BUTTON_ENABLED_BG_COLOR : COLORS.BUTTON_DISABLE_BG_COLOR)
                                .cornerRadius(STYLE_VARIABLES.SORT_BUTTON_CORNER_RADIUS) // Add rounded corners
                                .overlay(
                                    RoundedRectangle(cornerRadius: STYLE_VARIABLES.SORT_BUTTON_CORNER_RADIUS)
                                        .stroke(appModel.draftUserFilters.sortBy == .alphabetical_asc ? COLORS.BUTTON_ENABLED_BORDER_COLOR : COLORS.BUTTON_DISABLE_BORDER_COLOR, lineWidth: 2) // Add blue border
                                )
                        }
                        
                        Button{
                            //action
                            appModel.draftUserFilters.sortBy = .distance_asc
                        }label: {
                            HStack{
                                Image(systemName: "checkmark").font(.system(size: 16)).opacity(appModel.draftUserFilters.sortBy == .alphabetical_asc ? 0 : 1)
                                
                                Text("By Distance")
                                    .font(.headline)
                                    .foregroundStyle(appModel.draftUserFilters.sortBy == .distance_asc ? COLORS.BUTTON_ENABLED_TEXT_COLOR : COLORS.BUTTON_DISABLED_TEXT_COLOR)
                                
                            } .padding(12) // Add padding to increase the button size
                                .background(appModel.draftUserFilters.sortBy == .distance_asc ? COLORS.BUTTON_ENABLED_BG_COLOR : COLORS.BUTTON_DISABLE_BG_COLOR)
                                .cornerRadius(STYLE_VARIABLES.SORT_BUTTON_CORNER_RADIUS) // Add rounded corners
                                .overlay(
                                    RoundedRectangle(cornerRadius: STYLE_VARIABLES.SORT_BUTTON_CORNER_RADIUS)
                                        .stroke(appModel.draftUserFilters.sortBy == .distance_asc ? COLORS.BUTTON_ENABLED_BORDER_COLOR : COLORS.BUTTON_DISABLE_BORDER_COLOR, lineWidth: 2) // Add blue border
                                )
                        }
                    }
                    
                }
                
                
                
                VStack{
                    
                    
                    Divider().padding(.vertical, 8)
                    
                    
                    FeatureFilter(appModel: appModel)
                    Divider().padding(.vertical, 8)
                    
                    CategoryFilter(appModel: appModel)
                    
                    Divider().padding(.vertical, 8)
                    
                    Spacer()
                    
                    
                    
                    
                }
            }
            HStack{
                Spacer()
                Button {
                    appModel.applyFilters()
                    isSheetPresented = false
                } label: {
                    Text("Apply Filters")
                } .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                Spacer()
            }.padding(.top, 16)
                .background(.white)
            
            
            
            
            
            
            
        }.onAppear{
            appModel.draftUserFilters = appModel.userFilters
            
        }
        //        .background(COLORS.BACKGROUND_COLOR)
    }
}


struct SearchFiltersView_Previews: PreviewProvider {
    static var previews: some View {
        let appModel = AppModel()
        SearchFiltersView(appModel: appModel, isSheetPresented: .constant(true))
        
    }
}
