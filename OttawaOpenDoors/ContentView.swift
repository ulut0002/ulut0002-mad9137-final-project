//
//  ContentView.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-22.
//

import SwiftUI


enum ACTIVE_SCREEN {
    case main
    case map
    case saved
    case more
}

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
//                print("selected: 0")
                appModel.activeScreen = .main
                appModel.setTopBarTitle(newTitle: "Buildings")
                appModel.topBarShowTrailingComponents = true
            }else if (selection == 1){
                appModel.activeScreen = .map
                appModel.setTopBarTitle(newTitle: "Map")
                appModel.topBarShowTrailingComponents = true

            }else if (selection == 2){
                appModel.activeScreen = .saved
                appModel.setTopBarTitle(newTitle: "Saved")
                appModel.topBarShowTrailingComponents = true

                
            }else if (selection == 3){
                appModel.activeScreen = .more
                appModel.setTopBarTitle(newTitle: "More")
                appModel.topBarShowTrailingComponents = false
            }
        }).onAppear(){
//            appModel.topBarTitle = "Buildings"
            appModel.activeScreen = .main
            appModel.setTopBarTitle(newTitle: "Buildings")
            appModel.retrieve()

        }
    }
}

#Preview {
    ContentView()
}
