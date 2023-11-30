//
//  Models.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-28.
//

import Foundation
import SwiftUI



// Represents a building category
struct Category : Codable, Identifiable, Equatable {
    let id: Int
    let definition: String
    
    // Equatable conformance for comparison
    static func == (lhs: Category, rhs: Category) -> Bool {
        return (lhs.id == rhs.id)
    }
}

struct SearchFilter {
    var searchDescription: [PreferredLanguage : String] = [.english : "", .french: ""]
    var sortBy: SortBy = .alphabetical_asc
    var categories : [Category] = []
    var keyword: String = ""
    var features: [BuildingFeature] = []
    
    static func  getDefaultSearchFilter() -> SearchFilter {
        var filter = SearchFilter()
        filter.searchDescription = [.english: "", .french: ""]
        filter.sortBy = .alphabetical_asc
        filter.categories = []
        filter.keyword = ""
        filter.features = []
        return filter
    }
}



class BuildingListModel: ObservableObject {
    var masterBuildingList: [Building] = []
}



// Represents app model for all the data manipulation
class AppModel : ObservableObject{
    private var selectedLanguage: PreferredLanguage = .english
    var buildingsMaster: [PreferredLanguage: [Building]] = [.english: [], .french: []]
    var categoriesMaster:[PreferredLanguage: [Category]] = [.english: [], .french: []]
    var favoritesMaster: [String] = [] // only contains IDs


    @Published  var filteredBuildings: [Building] = []
    @Published  var filteredFavorites: [Building] = []
    @Published  var userFilters: SearchFilter = SearchFilter.getDefaultSearchFilter()
    @Published var draftUserFilters: SearchFilter = SearchFilter.getDefaultSearchFilter()
    
    @Published var fetchStatus:FetchStatus = .idle
    @Published var activeScreen:ActiveScreen = .main
    
}




// MARK: Filtering Buildings
extension AppModel {
    
    func filterBuildings(sourceData: [Building], searchFilter: SearchFilter) -> [Building]{
        var results: [Building] = sourceData
        
        // Filter by given categories
        if (!searchFilter.categories.isEmpty && searchFilter.categories.count != categoriesMaster[selectedLanguage]?.count){
            results = results.filter{building in
                return building.hasAnyCategory(categories: searchFilter.categories)
            }
        }
        
        
        // Filter by given features
        if (!searchFilter.features.isEmpty){
            results = results.filter{ building in
                return building.hasAnyFeature(features: searchFilter.features)
            }
        }
    
        // search by keyword in remaining elements
        let cleanKeyword1 = searchFilter.keyword.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        if (!cleanKeyword1.isEmpty){
            results = results.filter { building in
                return building.hasKeyword(searchKeyword: searchFilter.keyword)
            }
        }
        
        return results
    }
    
   
}


// MARK: Sort Buildings
extension AppModel{
    func sortBuildings(sourceData: [Building], sortBy: SortBy) -> [Building]{
        return  sourceData.sorted(by: { (building1, building2) -> Bool in
            return compareBuildings(building1,  building2, sortBy)
        })
    }
    
    func setSortBy(sortBy: SortBy){
        self.userFilters.sortBy = sortBy
    }
    
}



// MARK: Switch Language, set Language
extension AppModel {
    func switchLanguage(){
        selectedLanguage = (selectedLanguage == .english) ? .french : .english
    }
    
    func setLanguage(language: PreferredLanguage){
        selectedLanguage = language
    }
}







