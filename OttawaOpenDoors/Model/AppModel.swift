//
//  AppModel.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-23.
//

import Foundation
import SwiftUI

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
    
    
    
    @Published var activeScreen:ACTIVE_SCREEN = .main
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
    
    
    // search bar variables
    @Published var mainScreenStartAnimation = false
    @Published var mainScreenShowSearchBar = false
    @Published var mainScreenSearchBarText = ""
    
    
    @Published var favScreenShowSearchBar = false
    @Published var favScreenSearchBarText = ""
    
    
    
    func toggleSearchBar(){
        

        
        
        DispatchQueue.main.async {
            withAnimation(.easeInOut(duration: 0.25)){
                switch self.activeScreen {
                case .main:
                    self.mainScreenShowSearchBar.toggle()
                    print("Switched \(self.mainScreenShowSearchBar)")
                case .map:
                    break;
                case .saved:
                    self.favScreenShowSearchBar.toggle()
                case .more:
                    break;
                    
                    
                }
            }completion: {
                // show the actual bar
                
            }
            
        }
    }
    
    func setTopBarTitle(newTitle: String){
        DispatchQueue.main.async {
            self.topBarTitle = newTitle
        }
    }
    
    func setShowTrailingComponents(setShow: Bool){
        DispatchQueue.main.async {
            self.topBarShowTrailingComponents = setShow
        }
    }
    
    
//    func retriev
    
    
}


