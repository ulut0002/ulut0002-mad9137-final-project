//
//  OttawaOpenDoorsApp.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-22.
//

import SwiftUI

@main
struct OttawaOpenDoorsApp: App {
    @StateObject var locationManager = LocationManager()
    @StateObject var appLanguageManager = AppLanguageManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(locationManager)
                .environmentObject(appLanguageManager)
        }
    }
}
