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
    
    //already read the storage
    
    @StateObject var appModel = AppModel()
    
    
    @State private var selection = 0
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var appLanguageManager: AppLanguageManager
    
    @State var tintColor:Color = COLORS.BRAND_COLOR
    
    @EnvironmentObject var locationManager:LocationManager
    
    @State var labelHome:String = ""
    @State var labelMap: String = ""
    @State var labelSaved: String = ""
    @State var labelMore: String = ""
    
    @State private var isSplashDisplayed:Bool = false
    
    @State private var isSetupDone = false
    
    

    
    private func hideSplash() {
        isSplashDisplayed = true
    }
    
    var body: some View {
        VStack{
            if (isSplashDisplayed){
                
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
               
                
                .tint(colorScheme == .dark ? COLORS.NAVIGATION_TINT_COLOR_LIGHT : COLORS.NAVIGATION_TINT_COLOR_DARK)
                .task {
                    do{
                        try await  appModel.retrieve()
                    }catch{
                        
                    }
                } .onAppear(){
                    appLanguageManager.locale = appModel.locale
                    updateTabBarColor()
                    setLabels()
                }  .onChange(of: colorScheme, {
                    updateTabBarColor()
                    
                }).onChange(of: appModel.locale, {
                    appLanguageManager.locale = appModel.locale
                    setLabels()
                

                })
              
                
            }
        else {
            SplashScreen(appModel: appModel,hideSplash: hideSplash)
                
            }
        }.onAppear(){
            if (isSetupDone){
                
            }else{
                isSetupDone = true
//                appModel.setAppLanguageManager(mgr: appLanguageManager)
            }
        }.onChange(of: locationManager){
            
        }
        
        
    }
    
    private func updateTabBarColor() {
        let appearance = UITabBar.appearance()
        appearance.backgroundColor = UIColor(.white)
        
        
        
        
    }
    
    private func setLabels(){
        labelHome = "Navigation_Home".localizeString(string: appModel.locale.identifier)
        
        
        
        labelMap = "Navigation_Map".localizeString(string:  appModel.locale.identifier)
        
        labelSaved = "Navigation_Saved".localizeString(string: appModel.locale.identifier)
        
        labelMore = "Navigation_More".localizeString(string:  appModel.locale.identifier)
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
