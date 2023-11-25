//
//  ContentView.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var appModel = AppModel()
    @State private var selection = 0


    
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
            
            SavedView(appModel: appModel).tabItem(){
                Image(systemName: "suit.heart.fill")
                Text(LocalizedStringKey("Navigation_Saved"))
            }.badge(10).tag(2)
            MoreView(appModel: appModel).tabItem(){
                Image(systemName: "ellipsis")
                Text(LocalizedStringKey("Navigation_More"))
            }.tag(3)
            ShareInfo().tabItem(){
                Image(systemName: "square.and.arrow.up")
                Text("Share")
            }.tag(4)
        }.onChange(of: selection, {
            if (selection == 0){
                print("selected: 0")
                appModel.setTopBarTitle(newTitle: "Buildings")
                appModel.topBarShowTrailingComponents = true
            }else if (selection == 1){
                appModel.setTopBarTitle(newTitle: "Map")
                appModel.topBarShowTrailingComponents = true
                print("selected: 1")

            }else if (selection == 2){
                appModel.setTopBarTitle(newTitle: "Saved")
                appModel.topBarShowTrailingComponents = true
                print("selected: 2")

                
            }else if (selection == 3){
                print("selected: 3")

                appModel.setTopBarTitle(newTitle: "More")
                appModel.topBarShowTrailingComponents = false
            }
        }).onAppear(){
//            appModel.topBarTitle = "Buildings"
           
            appModel.setTopBarTitle(newTitle: "Buildings")
            appModel.retrieve()

        }
    }
}

#Preview {
    ContentView()
}
