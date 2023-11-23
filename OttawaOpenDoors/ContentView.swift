//
//  ContentView.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        //        BottomNavigation()
        TabView{
            MainView().tabItem(){
                Image(systemName: "house")
                Text(LocalizedStringKey("Navigation_Home"))
            }
            MapView().tabItem(){
                Image(systemName: "map")
                Text(LocalizedStringKey("Navigation_Map"))
            }
            
            SavedView().tabItem(){
                Image(systemName: "suit.heart.fill")
                Text(LocalizedStringKey("Navigation_Saved"))
            }.badge(10)
            MoreView().tabItem(){
                Image(systemName: "ellipsis")
                Text(LocalizedStringKey("Navigation_More"))
            }
        }
    }
}

#Preview {
    ContentView()
}
