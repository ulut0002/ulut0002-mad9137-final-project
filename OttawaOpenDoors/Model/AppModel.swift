//
//  AppModel.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-23.
//

import Foundation

enum TopNavigationBar {
    case visible
    case hidden
}


enum FETCH_STATUS {
    case fetching
    case error
    case idle
}

class AppModel: ObservableObject{
    
    @Published var masterBuildings: [Building] = []
    var masterFavoriteBuildings: [Building] = []
    
    @Published var fetchStatus:FETCH_STATUS = .idle
    
    @Published var buildings: [Building] = []
    @Published var favoriteBuildings: [Building] = []

 
    // top-bar navigation controls
    @Published var topBarVisible = true
    @Published var topBarTitle = ""
    @Published var topBarShowBackButton = false
    @Published var topBarShowLeadingLogo = true
    @Published var topBarShowTrailingComponents = true
    @Published var topBarSearchKeyword = ""
    @Published var topBarFilterCount = {
        return 0
    }
    
   
    
    
    func setTopBarTitle(newTitle: String){
        topBarTitle = newTitle
    }
    
    func setShowTrailingComponents(setShow: Bool){
        topBarShowTrailingComponents = setShow
    }
    
    
//    func retriev
    
    
}


