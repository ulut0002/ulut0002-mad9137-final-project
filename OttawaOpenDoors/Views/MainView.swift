//
//  MainView.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-22.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var appModel:AppModel
    @State var text = ""
    @State var search = true
    @State var buildingList: [Building] = []
    
    
  
    
    
    var body: some View {
        ZStack(){
            COLORS.BRAND_COLOR
            
            
            
            VStack{
                TopNavigation(appModel: appModel)


                VStack{
                    // Removes the gap between the list and the navigation
                }
                
             

                VStack{

                    if (appModel.fetchStatus == .fetching){
                        
                    }
                    
                    if (appModel.fetchStatus == .idle){
                        if (appModel.mainScreenShowSearchBar){
                            SearchBar(searchKeyword: $appModel.topBarSearchKeyword, toggleSearch: appModel.toggleSearchBar)
                        }
                        
                        
                        ScrollView{
                            LazyVStack{
                                ForEach(appModel.masterBuildingList[appModel.selectedLanguage] ?? [], id: \.id){ building in
                                    VStack{
                                        ZStack(alignment: .top){
                                            
                                            Image(building.imageResourceName)
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: UIScreen.main.bounds.width, height: 140)
                                                .clipped()
                                                .overlay(
                                                    HStack() {
                                                        Spacer()
                                                        HStack {
                                                            Image(systemName: "heart")
                                                                .foregroundColor(.white)
                                                                .padding(4)
                                                            
                                                            Image(systemName: "square.and.arrow.up")
                                                                .foregroundColor(.white)
                                                                .padding(4)
                                                        }
                                                  
                                                        .background(Color.black.opacity(0.6))
//                                                        .cornerRadius(10)
                                                        .padding(10)
                                                    }
                                                )
                                            
                                            
                                           
                                            
                                            
                                        }
                                        Text(building.name!).background(Color.white)
                                        
                                        
                                    }.background(Color.white)
                                }.onTapGesture {
                                    appModel.switchLanguage()
                                }
                                
                            }.background(Color.white)
//                            
                        }.shadow(radius:2)
                            .listStyle(PlainListStyle())
                            .frame(height: .infinity)
                            .listRowSeparator(.hidden)
                     
                            .padding(0)
                    }
                    
                }
//                Spacer()
                
            }
//            .frame(maxHeight: .infinity)
          
            
        }
    }
    
}


struct SearchBar: View {
//    @ObservedObject var appModel:AppModel
    @Binding var searchKeyword: String
     var toggleSearch: () -> Void

    
    var body: some View {
        HStack {
            TextField("Search", text: $searchKeyword)
                .padding(8)
                .background(Color.white)
                .cornerRadius(8)
                .padding(8)

            Button(action: {
                if (searchKeyword.isEmpty){
                    toggleSearch()
                }else{
                    searchKeyword = ""

                }
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
                    .padding(8)
            }
        }
    }
}
