//
//  OttawaOpenDoorsApp.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-22.
//

import SwiftUI
import Firebase

@main
struct OttawaOpenDoorsApp: App {
    @StateObject var locationManager = LocationManager()
    @StateObject var appLanguageManager = AppLanguageManager()
    @StateObject var networkMonitor = NetworkMonitor()
    
    init(){
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(locationManager)
                .environmentObject(appLanguageManager)
                .environmentObject(networkMonitor)
        }
    }
}
