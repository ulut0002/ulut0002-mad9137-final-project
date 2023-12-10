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
    @State private var selection = 0
    @Environment(\.colorScheme) var colorScheme
    @State var tintColor:Color = COLORS.BRAND_COLOR
    
    @EnvironmentObject var locationManager:LocationManager
    
    
    init(appModel: AppModel = AppModel(), selection: Int = 0) {
        self.appModel = appModel
        self.selection = selection
        
        
    }
    
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
        }
        
        
        
        .onAppear(){
            updateTabBarColor()
        }.tint(colorScheme == .dark ? COLORS.NAVIGATION_TINT_COLOR_LIGHT : COLORS.NAVIGATION_TINT_COLOR_DARK)
            .onChange(of: colorScheme, {
                updateTabBarColor()
                
            }).task {
                
                do{
                    try await  appModel.retrieve()
                    //locationManager.retrieveLocation()
                }catch{
                    
                }
                
                
            }
        
        
        
    }
    
    private func updateTabBarColor() {
        let appearance = UITabBar.appearance()
        appearance.backgroundColor = UIColor(.white)
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View{
        let location = LocationManager()
        ContentView()
            .environmentObject(location)
    }
}
