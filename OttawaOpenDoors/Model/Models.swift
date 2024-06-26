//
//  Models.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-28.
//

import Foundation
import SwiftUI




// Represents a building category
struct Category {
    var option: BuildingCategory
    var selected: Bool = false
    
    
    var description: [PreferredLanguage: String] = [.english: "", .french: ""]
    
    func matchBuilding(building: Building) -> Bool {
        if (!selected){
            return true
        }
        
        switch option {
        case .academic:
            return building.categoryId == 5
        case .business_foundatation:
            return building.categoryId == 8
        case .community_center:
            return building.categoryId == 7
        case .embassy:
            return building.categoryId == 1
        case .functional_building:
            return building.categoryId == 3
        case .gallery_theatre:
            return building.categoryId == 4
        case .government:
            return building.categoryId == 2
        case .museum_archive_historic:
            return building.categoryId == 9
        case .other:
            return building.categoryId == 10
        case .religious_building:
            return building.categoryId == 0
        case .sports_leisure:
            return building.categoryId == 6
        }
    }
    
}


struct CategoryFilterGroup{
    var government = Category(option: .government)
    var communityCenter = Category(option: .community_center)
    var business = Category(option: .business_foundatation)
    var museum = Category(option: .museum_archive_historic)
    var sports = Category(option: .sports_leisure)
    var gallery = Category(option: .gallery_theatre)
    var other = Category(option: .other)
    var functionalBuilding = Category(option: .functional_building)
    var academic = Category(option: .academic)
    var embassy = Category(option: .embassy)
    var religious = Category(option: .religious_building)
    
    func getAllOptionsAsArray() -> [Category]{
        return [government,
                communityCenter,
                business,
                museum,
                sports,
                gallery,
                other,
                functionalBuilding,
                academic,
                embassy]
    }
    
    var hasAppliedAllFilters: Bool {
        let allOptions = getAllOptionsAsArray()
        return allOptions.allSatisfy({$0.selected}) || allOptions.allSatisfy({!$0.selected})
    }
    
    func matchBuilding(building: Building) -> Bool {
        if hasAppliedAllFilters {
            return true
        }
        let allOptions = getAllOptionsAsArray()
        return allOptions.allSatisfy({$0.matchBuilding(building: building)})
    }
}


// Identifies a selectable feature (turn on/off)
struct Feature:Identifiable{
    var id: Int{
        return option.self.hashValue
    }
    let option: BuildingFeature
    var selected: Bool = false
    
    
    
    
    func matchBuilding(building: Building) -> Bool {
        if (!selected){
            return true
        }
        
        switch option {
        case .accessible:
            return building.isAccessible ?? true
        case .bikeParking:
            return building.isBikeParking ?? true
        case .familyFriendly:
            return building.isFamilyFriendly ?? true
        case .freeParking:
            return building.isFreeParking  ?? true
        case .guidedTour:
            return building.isGuidedTour ?? true
        case .isNew:
            return building.isNew ?? true
        case .oCTranspoNearby:
            return building.isOCTranspoNearby ?? true
        case .openSaturday:
            return building.isOpenSaturday ?? true
        case .openSunday:
            return building.isOpenSunday ?? true
        case .paidParking:
            return building.isPaidParking ?? true
        case .publicWashroom:
            return building.isPublicWashrooms ?? true
        case .shuttleBus:
            return building.isShuttle ?? true
            
        }
    }
}

// represents 1) actual filters  2) Draft filter before user applies them
struct FeatureFilterGroup {
    var accessible = Feature(option: .accessible)
    var bikeParking = Feature(option: .bikeParking)
    var familyFriendly = Feature(option: .familyFriendly)
    var freeParking = Feature(option: .freeParking)
    var guidedTour = Feature(option: .guidedTour)
    var isNew = Feature(option: .isNew)
    var oCTranspoNearby = Feature(option: .oCTranspoNearby)
    var openSaturday = Feature(option: .openSaturday)
    var openSunday = Feature(option: .openSunday)
    var paidParking = Feature(option: .paidParking)
    var publicWashroom = Feature(option: .publicWashroom)
    var shuttleBus = Feature(option: .shuttleBus)
    // modify getAllOptionsAsArray for every new feature
    
    func getAllOptionsAsArray() -> [Feature] {
        return  [accessible,
                 bikeParking,
                 familyFriendly,
                 freeParking,
                 guidedTour,
                 isNew,
                 oCTranspoNearby,
                 openSaturday,
                 openSunday,
                 paidParking,
                 publicWashroom,
                 shuttleBus]
    }
    
    var hasAppliedAllFilters: Bool {
        let allOptions = getAllOptionsAsArray()
        return allOptions.allSatisfy({$0.selected}) || allOptions.allSatisfy({!$0.selected})
        
    }
    
    
    func matchBuilding(building: Building) -> Bool {
        if (hasAppliedAllFilters){
            return true
        }
        let allOptions = getAllOptionsAsArray()
        return allOptions.allSatisfy({$0.matchBuilding(building: building)})
    }
}






// represents group of filters on the app.
struct Filters {
    var searchDescription: [PreferredLanguage : String] = [.english : "", .french: ""]
    var sortBy: SortBy = .alphabetical_asc
    var categories = CategoryFilterGroup()
    var keyword: String = ""
    var features = FeatureFilterGroup()
    
    static func  getDefaultSearchFilter() -> Filters {
        var filter = Filters()
        filter.searchDescription = [.english: "", .french: ""]
        filter.sortBy = .alphabetical_asc
        filter.categories =  CategoryFilterGroup()
        filter.keyword = ""
        filter.features = FeatureFilterGroup()
        return filter
    }
    
    var hasFilter: Bool{
        return true
    }
}



class BuildingListModel: ObservableObject {
    var masterBuildingList: [Building] = []
}



// Represents app model for all the data manipulation
class AppModel : ObservableObject{
    
    
    
    private var appLanguageManager: AppLanguageManager? = nil
    
    init(){
        readUserConfigurationFromStorage()
    }
    
    @Published private(set) var userConfig: ConfigModel = ConfigModel.getDefaultConfigModel()
    private var selectedLanguage: PreferredLanguage = .english
    
    var buildingsMaster: [PreferredLanguage: [Building]] = [.english: [], .french: []]
    @Published var buildingMasterEn: [Building] = []
    @Published var buildingMasterFr: [Building] = []
    
    var categoriesMaster:[Category] = []
    var favoritesMaster: [BookmarkInfo] = [] // only contains IDs
    
    @Published  var filteredBuildings: [Building] = []
    @Published  var filteredFavorites: [Building] = []
    @Published  var userFilters: Filters = Filters.getDefaultSearchFilter()
    @Published var draftUserFilters: Filters = Filters.getDefaultSearchFilter()
    
    @Published  var favoriteFilters: Filters = Filters.getDefaultSearchFilter()
    @Published var draftFavoriteFilters: Filters = Filters.getDefaultSearchFilter()
    
    
    @Published var fetchStatus:FetchStatus = .idle
    @Published var activeScreen:ActiveScreen = .main
    
    @Published private(set) var buildingDetailShowAllDescription: Bool = false
    @Published private(set) var buildingDetailShowAllAmenities: Bool = false
    @Published private(set) var buildingAmenities = BuildingFeature.getAmenitiesAsArray()
    
    @Published private(set) var locale = Locale(identifier: CONFIGURATION.LANG_EN)
    
    private var locationManager: LocationManager?
    
    
    //    setBuildingDetailShowLongDescription
    
    func setAppLanguageManager(mgr: AppLanguageManager){
        self.appLanguageManager = mgr
    }
    
}




// MARK: Filtering Buildings
extension AppModel {
    
    func filterBuildings(sourceData: [Building], searchFilter: Filters) -> [Building]{
        var filteredBuildings: [Building] = sourceData
        let categories = searchFilter.categories
        let features = searchFilter.features
        let keyword = searchFilter.keyword
        
        if (!categories.hasAppliedAllFilters){
            filteredBuildings = filteredBuildings.filter({ building in
                return categories.matchBuilding(building: building)
            })
        }
        
        
        if (!features.hasAppliedAllFilters){
            filteredBuildings = filteredBuildings.filter({ building in
                return features.matchBuilding(building: building)
            })
        }
        
        
        // search by keyword in remaining elements
        let cleanKeyword1 = keyword.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        if (!cleanKeyword1.isEmpty){
            filteredBuildings = filteredBuildings.filter { building in
                return building.hasKeyword(searchKeyword: keyword)
            }
        }
        
        
        
        filteredBuildings = sortBuildings(sourceData: filteredBuildings, sortBy: self.userFilters.sortBy)
        
        
        return filteredBuildings
    }
    
    
}

// Draft filter functions
extension AppModel {
    func applyFilters(){
        userFilters = draftUserFilters
        
        
        
        let newBuildings = filterBuildings(sourceData: buildingsMaster[selectedLanguage] ?? [], searchFilter: userFilters)
        
        self.filteredBuildings = newBuildings
        
        
        
    }
    
    func applyFavoriteFilters(){
        favoriteFilters = draftFavoriteFilters
        filterBookmarks()
    }
    
    func resetFilters() {
        draftUserFilters = Filters.getDefaultSearchFilter()
    }
    
    func resetBookmarkFilters() {
        draftFavoriteFilters = Filters.getDefaultSearchFilter()
    }
    
}




// MARK: Sort Buildings
extension AppModel{
    func sortBuildings(sourceData: [Building], sortBy: SortBy) -> [Building]{
        return  sourceData.sorted(by: { (building1, building2) -> Bool in
//            if (building1.distanceFromUserLocation == nil && self.locationManager != nil){
//                if let targetLocation = building1.coordinate {
//                    if let distance = self.locationManager?.getDistance(targetLocation: targetLocation){
//                        building1.distanceFromUserLocation = distance
//                    }
//                }
//            }
//            
//            if (building2.distanceFromUserLocation == nil){
//                
//            }
            return compareBuildings(building1,  building2, sortBy)
        })
    }
    
    func setSortBy(sortBy: SortBy){
        self.userFilters.sortBy = sortBy
    }
    
}



// MARK: Switch Language, set Language
extension AppModel {
    static var currentLanguage: String {
        get {
            return UserDefaults.standard.string(forKey: "AppLanguage") ?? "en"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "AppLanguage")
        }
    }
    
    
    
    
    
    func setLanguage(language: PreferredLanguage){
        let selectedLang:PreferredLanguage = language
        if (selectedLang == .unknown){
            return
        }
        
        if (selectedLang == .english){
            locale =  Locale(identifier: CONFIGURATION.LANG_EN)
        }else if (selectedLang == .french){
            locale =  Locale(identifier: CONFIGURATION.LANG_FR)
        }else{
            return
        }
        
        let newUserConfig:ConfigModel = ConfigModel(lang: locale.identifier,
                                                    preferredLanguage:  selectedLang)
        selectedLanguage = selectedLang
        userConfig = newUserConfig
        self.locale = locale
        
        saveUserConfigurationToStorage()
        readUserConfigurationFromStorage()
        
        
        
        
        
        
        
        
        Task {
            //            try await  retrieve()
            
            do{
                try await  self.retrieve()
            }catch{
                
            }
        }
    }
    
    
}

extension AppModel{
    func toggleBuildingDetailShowLongDescription() {
        self.buildingDetailShowAllDescription.toggle()
    }
    
    
    func toggleBuildingDetailShowAllAmenities(){
        self.buildingDetailShowAllAmenities.toggle()
    }
    
}


// MARK: User Settings
extension AppModel{
    
    
    func saveUserConfigurationToStorage(){
        if let encodeData = try? JSONEncoder().encode(userConfig){
            UserDefaults.standard.set(encodeData, forKey: CONFIGURATION.STORAGE_KEY_CONFIGURATION)
            
        }
    }
    
    func readUserConfigurationFromStorage(){
        if let userData = UserDefaults.standard.data(forKey: CONFIGURATION.STORAGE_KEY_CONFIGURATION), let decodedData = try? JSONDecoder().decode(ConfigModel.self, from: userData){
            self.userConfig = decodedData
            self.selectedLanguage = decodedData.preferredLanguage
            if self.selectedLanguage == .english {
                self.locale = Locale(identifier: CONFIGURATION.LANG_EN)
            }
            if selectedLanguage == .french {
                self.locale = Locale(identifier: CONFIGURATION.LANG_FR)
            }
            
            return
        }
        
        //create a blank one, save it, amd return it
        let initModel = ConfigModel.getDefaultConfigModel()
        self.userConfig = initModel
        
        saveUserConfigurationToStorage()
        readUserConfigurationFromStorage()
        
    }
    
    
}


// MARK: handle location info update
extension AppModel {
    
    func setLocationManager(locationManager: LocationManager? ){
        self.locationManager = locationManager
        
     
        
    }
    
    func updateLocationDistance(id: Int, value: Double){
        if let idx = buildingsMaster[.english]?.firstIndex(where: {$0.id == id}){
            buildingsMaster[.english]?[idx].distanceFromUserLocation = value
        }
        
        if let idx = buildingsMaster[.french]?.firstIndex(where: {$0.id == id}){
            buildingsMaster[.french]?[idx].distanceFromUserLocation = value
        }
        
    }
}


// MARK: Handle favorites
extension AppModel {
    
    func toggleBookmark(building: Building){
        
        let newBookmarkInfo = BookmarkInfo(id: building.id, bookmarkDate: .now)
        if !favoritesMaster.contains(newBookmarkInfo){
            
            self.favoritesMaster.append(newBookmarkInfo)
            
            
            // save it local storage
            saveBookmarksToStorage()
            
            // update the state
            setBookmarkFlag(building.id, true)
            
            
        }else {
            // remove from bookmarks]
            
            favoritesMaster.removeAll(where: {$0.id == newBookmarkInfo.id})
            
            // save it local storage
            saveBookmarksToStorage()
            
            setBookmarkFlag(building.id, false)
            
            
        }
        
    }
    
    
    
    private func saveBookmarksToStorage(){
        if let encodeData = try? JSONEncoder().encode(favoritesMaster){
            UserDefaults.standard.set(encodeData, forKey: CONFIGURATION.STORAGE_KEY_SAVED_BUILDINGS)
        }
    }
    
    func readBookmarksFromStorage() -> [BookmarkInfo]{
        if let bookmarkData = UserDefaults.standard.data(forKey: CONFIGURATION.STORAGE_KEY_SAVED_BUILDINGS), let decodedData = try? JSONDecoder().decode([BookmarkInfo].self, from: bookmarkData){
            return decodedData
        }
        return []
    }
    
    
    
    
    
    
    private func setBookmarkFlag(_ id: Int, _ markAsFavorite: Bool){
        let date: Date = .now
        
        
        if var englishBuildings = buildingsMaster[.english] {
            if let idx =  englishBuildings.firstIndex(where: {$0.id == id}){
                if markAsFavorite {
                    let bookmarkInfo = BookmarkInfo(id: id, bookmarkDate: date)
                    englishBuildings[idx].bookmarkInfo = bookmarkInfo
                }else{
                    englishBuildings[idx].bookmarkInfo = nil
                }
            }
            
        }
        
        if var frenchBuildings = buildingsMaster[.french] {
            if let idx =  frenchBuildings.firstIndex(where: {$0.id == id}){
                if markAsFavorite {
                    let bookmarkInfo = BookmarkInfo(id: id, bookmarkDate: date)
                    frenchBuildings[idx].bookmarkInfo = bookmarkInfo
                    
                }else{
                    frenchBuildings[idx].bookmarkInfo = nil
                }
            }
            
        }
        
        
        
        if let idx = filteredBuildings.firstIndex(where: {$0.id == id}) {
            if markAsFavorite {
                let bookmarkInfo = BookmarkInfo(id: id, bookmarkDate: date)
                filteredBuildings[idx].bookmarkInfo = bookmarkInfo
            }else{
                filteredBuildings[idx].bookmarkInfo = nil
            }
        }
        
        
        //re-generate the bookmarks list
        filterBookmarks()
        
        
    }
    
    func filterBookmarks(){
        
        
        let categories = favoriteFilters.categories
        let features = favoriteFilters.features
        let keyword = favoriteFilters.keyword
        
        
        
        
        
        do{
            var bookmarks : [Building] = []
            let sortedBookmarks = favoritesMaster.sorted(by: {$0.bookmarkDate >= $1.bookmarkDate})
            
            
            for bookmarkInfo in sortedBookmarks {
                if let building = buildingsMaster[selectedLanguage]?.first(where: {$0.id == bookmarkInfo.id}){
                    
                    //check if the building matches with the filters
                    let categoryMatch = categories.matchBuilding(building: building)
                    let featureMatch = features.matchBuilding(building: building)
                    var hasKeyword = true
                    let cleanKeyword1 = keyword.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    if (!cleanKeyword1.isEmpty){
                        hasKeyword = building.hasKeyword(searchKeyword: keyword)
                        
                    }
                    if (featureMatch && categoryMatch && hasKeyword){
                        bookmarks.append(building)
                    }
                }
            }
            
            bookmarks = sortBuildings(sourceData: bookmarks, sortBy: self.favoriteFilters.sortBy)
            
            self.filteredFavorites = bookmarks
            
            
        }
    }
}




