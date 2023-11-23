//
//  BottomNavigation.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-22.
//

import SwiftUI

struct BottomNavigation: View {
    
    @State var selectedIndex:Int = 0
    @State var someText = ""
    
    init(){
        // UITabBar.appearance().backgroundColor = UIColor.blue
    }
    
    var body: some View {
        TabView {
            NavigationView {
                MainView()
            }
            .tabItem {
                Image(systemName: "house")
                Text(LocalizedStringKey("Navigation_Home"))
            }.navigationBarBackButtonHidden()
            
            NavigationStack {
                // Content for the second tab
                MapView()
            }
            .tabItem {
                Image(systemName: "map")
                Text(LocalizedStringKey("Navigation_Map"))
            }
            
            NavigationStack {
                // Content for the third tab
                SavedView()
            }
            .tabItem {
                Image(systemName: "suit.heart.fill")
                Text(LocalizedStringKey("Navigation_Saved"))
            }
            
            NavigationStack {
                // Content for the fourth tab
               MoreView()
            }
            .tabItem {
                
                Image(systemName: "ellipsis")
                Text(LocalizedStringKey("Navigation_More"))
                
            }
        }
    }
}

#Preview {
    BottomNavigation()
}
