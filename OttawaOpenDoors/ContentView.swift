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
    @State private var selection = 3
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var appLanguageManager: AppLanguageManager

    @State var tintColor:Color = COLORS.BRAND_COLOR
    
    @EnvironmentObject var locationManager:LocationManager
    
    @State var labelHome:String = ""
    @State var labelMap: String = ""
    @State var labelSaved: String = ""
    @State var labelMore: String = ""
    
    init(appModel: AppModel = AppModel(), selection: Int = 0) {
        self.appModel = appModel
        self.selection = selection
        
      
        
        
    }
    
    var body: some View {
        
        
        TabView(selection: $selection){
            MainView(appModel: appModel)
                .tabItem(){
                    Image(systemName: "house")
                    Text(labelHome)
                }.tag(0)
            
            
            MapView(appModel: appModel).tabItem(){
                Image(systemName: "map")
                Text(labelMap)
            }.tag(1)
            
            SavedView(appModel: appModel)
                .tabItem(){
                    Image(systemName: "suit.heart.fill")
                    Text(labelSaved)
                }.badge(appModel.filteredFavorites.count).tag(2)
                
            MoreView(appModel: appModel).tabItem(){
                Image(systemName: "ellipsis")
                Text(labelMore)
            }.tag(3)
        }
        
        
        
        .onAppear(){
            updateTabBarColor()
            setLabels()
            

        }.onChange(of: appModel.userConfig.preferredLanguage, {
            appLanguageManager.locale = Locale(identifier: appModel.userConfig.lang)
            setLabels()
        })
        .tint(colorScheme == .dark ? COLORS.NAVIGATION_TINT_COLOR_LIGHT : COLORS.NAVIGATION_TINT_COLOR_DARK)
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
    
    private func setLabels(){

       labelHome = "Navigation_Home".localizeString(string: appModel.userConfig.lang)
        
        labelHome = "Navigation_Home".localizeString(string: appLanguageManager.locale.identifier)

       
        labelMap = "Navigation_Map".localizeString(string: appModel.userConfig.lang)
        
        labelSaved = "Navigation_Saved".localizeString(string: appModel.userConfig.lang)
        
        labelMore = "Navigation_More".localizeString(string: appModel.userConfig.lang)
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View{
        let location = LocationManager()
        let language = AppLanguageManager()
        let networkMonitor = NetworkMonitor()
        ContentView()
            .environmentObject(location)
            .environmentObject(language)
            .environmentObject(networkMonitor)
    }
}
