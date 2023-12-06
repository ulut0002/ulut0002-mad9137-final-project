//
//  ContentView.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-22.
//

import SwiftUI


enum ActiveScreen {
    case main
    case map
    case saved
    case more
}

struct ContentView: View {
    
    @ObservedObject var appModel = AppModel()
    @State private var selection = 1


    
    var body: some View {
  
            
            TabView(selection: $selection){
                MainView(appModel: appModel)
                    .tabItem(){
                        Image(systemName: "house")
                        Text(LocalizedStringKey("Navigation_Home"))
                    }.tag(0)
                
                
                MapView(appModel: appModel).tabItem(){
                    Image(systemName: "map")
                    Text(LocalizedStringKey("Navigation_Map"))
                }.tag(1)
                
                SavedView(appModel: appModel)
                    .tabItem(){
                    Image(systemName: "suit.heart.fill")
                    Text(LocalizedStringKey("Navigation_Saved"))
                    }.badge(appModel.filteredFavorites.count).tag(2)
                MoreView(appModel: appModel).tabItem(){
                    Image(systemName: "ellipsis")
                    Text(LocalizedStringKey("Navigation_More"))
                }.tag(3)
//                ShareInfo().tabItem(){
//                    Image(systemName: "square.and.arrow.up")
//                    Text("Share")
//                }.tag(4)
            }.onAppear(){
                appModel.retrieve()
                
            }
        
    }
}

#Preview {
    ContentView()
}
