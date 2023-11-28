//
//  AppModel.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-23.
//

import Foundation
import SwiftUI







class BuildingListModel: ObservableObject {
    var masterBuildingList: [Building] = []
}

class AppModel: ObservableObject{
    
    //master variables (internal)
    var selectedLanguage: PreferredLanguage = .english
    var masterBuildingList: [PreferredLanguage: [Building]] = [.english: [], .french: []]
    var masterCategoryList:[PreferredLanguage: [Category]] = [.english: [], .french: []]
    var masterFavoriteList: [Building] = []
    var sortBy: SortBy = .alphabetical
    
    func switchLanguage(){
        if (self.selectedLanguage == .english){
            selectedLanguage = .french
        }else{
            selectedLanguage = .english
        }
//        filteredBuildings = masterBuildingList[selectedLanguage] ?? []
        // TODO:
        // change all filteredbuildings
        // change all filtered categories
        
    }
    
    @Published var filteredBuildings: [Building] = []
    @Published var filteredCategories: [Category] = []
    @Published var appliedCategories: [Category] = []
    @Published var appliedFeatures: [BuildingFeature] = []
    @Published var filteredFavoriteBuildings: [Building] = []
    
    
    @Published var fetchStatus:FetchStatus = .idle
    @Published var activeScreen:ACTIVE_SCREEN = .main
    
    
    
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
    
    
    func setSearchKeyword(newKeyword: String){
        self.topBarSearchKeyword = newKeyword
    }
    
    func toggleBuildingCategory(selectedCategory: Int){
        // TODO: add/remove from the selected categories
    }
    
    func toggleBuildingFeature(feature: BuildingFeature){
        // TODO: add/remove building feature from the list
    }
    
    func setSearchSort(sort: SortBy){
        self.sortBy = sort
    }
    
    func retrieveBuildingList(){
        let searchKeyword = self.topBarSearchKeyword.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        if let masterList = masterBuildingList[selectedLanguage]{
            
            
            let newList = masterList.filter{ building in
                
                // SEARCH KEYWORD
                if (!searchKeyword.isEmpty), let buildingName = building.name {
                    let buildingNameClean = buildingName.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
                    if (buildingNameClean.contains(searchKeyword)){
                        return true
                    }
                }
                
                // Selected categories
                if (appliedCategories.isEmpty || appliedCategories.count == filteredCategories.count){
                    // all
                }else{
                    var categoryExists = false
                    for category in appliedCategories {
                        if (building.categoryId  == category.id){
                            categoryExists = true
                            break;
                        }
                    }
                    if (!categoryExists){
                        return false
                    }
                }
                
                
                // selected building features
                if (!appliedFeatures.isEmpty){
                    for feature in appliedFeatures {
                        switch feature {
                        case .accessible:
                            if let searchedFeature = building.isAccessible {
                                return searchedFeature
                            }
                            break;
                        case .bikeParking:
                            if let searchedFeature = building.isBikeParking {
                                return searchedFeature
                            }
                            break;
                        default:
                            <#code#>
                        }
                    }
                }
                
                return true
            }
        }
    }
    
    
    func toggleSearchBar(){
        DispatchQueue.main.async {
            withAnimation(.easeInOut(duration: 0.20)){
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




