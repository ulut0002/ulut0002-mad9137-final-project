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
    
    
    var body: some View {
        ZStack(){
            COLORS.BRAND_COLOR
            
            VStack{
                TopNavigation(appModel: appModel)
                VStack{
                    // Removes the gap between the list and the navigation
                }
                
                VStack{
                    if (appModel.mainScreenShowSearchBar){
                        SearchBar(text: $appModel.topBarSearchKeyword)
                    }

            
                    List{
                        LazyVStack{
                            ForEach(appModel.masterBuildings){ building in
                                VStack{
                                    ZStack(alignment: .topLeading){
                                        
                                        Image(building.imageResourceName)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: .infinity, height: 140)
                                            .clipped()
                                        
                                        HStack() {
                                            Spacer()
                                            HStack {
                                                Image(systemName: "heart")
                                                    .foregroundColor(.white)
                                                    .padding(8)
                                                
                                                Image(systemName: "square.and.arrow.up")
                                                    .foregroundColor(.white)
                                                    .padding(8)
                                            }
                                            .background(Color.black.opacity(0.6))
                                            .cornerRadius(10)
                                            .padding(10)
                                        }
                                        
                                        
                                    }
                                    Text(building.name!)
                                    
                                }
                            }
                            
                        }.clipShape(RoundedRectangle(cornerSize:
                                                        CGSize(width: 10, height: 10)))
                        
                    }.shadow(radius:2).listStyle(PlainListStyle())
                        
                    
                }
                
            }
            .frame(maxHeight: .infinity)
          
            
        }
    }
    
}


struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .padding(8)
                .background(Color.white)
                .cornerRadius(8)
                .padding(8)

            Button(action: {
                text = ""
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
                    .padding(8)
            }
        }
    }
}
