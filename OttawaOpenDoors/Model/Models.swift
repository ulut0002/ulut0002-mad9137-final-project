//
//  Models.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-28.
//

import Foundation



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
    var categories : [Category] = []
    var keyword: String = ""
    var features: [BuildingFeature] = []
}





// Represents app model for all the data manipulation
class AppDataModel : ObservableObject{
    var selectedLanguage: PreferredLanguage = .english
    var buildingsMaster: [PreferredLanguage: [Building]] = [.english: [], .french: []]
    var categoriesMaster:[PreferredLanguage: [Category]] = [.english: [], .french: []]
    var favoritesMaster: [String] = [] // only contains IDs


    @Published private(set) var filteredBuildings: [Building] = []
    @Published private(set) var filteredFavorites: [Building] = []
    
    @Published private(set) var appliedCategories: [Category] = []
    @Published private(set) var appliedFeatures: [BuildingFeature] = []
}



// MARK: Filters and sorts
extension AppDataModel {
    
    
    func filterBuildings(sourceData: [Building], searchFilter: SearchFilter) -> [Building]{
        var results: [Building] = sourceData
        
        var categories = searchFilter.categories
       
        if (!categories.isEmpty && categories.count != categoriesMaster[selectedLanguage]?.count){
            results = results.filter{building in
                
                var categoryFound = false
                
                for category in categories {
                    if (category.id == building.categoryId){
                        categoryFound = true
                        break;
                    }
                }
                return categoryFound
            }
            
        }
        
        
        var features = searchFilter.features
        if (!features.isEmpty){
            results = results.filter{ building in
                var featureFound = false
                
                for feature in features {
                    if (buildingHasFeature(feature: feature, building: building)){
                        featureFound = true
                        break;
                    }
                }
                return featureFound
            }
        }
        
        
        // search by keyword in remaining elements
        var cleanKeyword1 = searchFilter.keyword.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        var cleanKeyword2 = cleanKeyword1.replacingOccurrences(of: " ", with: "")
        
        if (!cleanKeyword1.isEmpty){
            results = results.filter { building in
                var buildingFound = false
                
                if let name = building.name {
                    var cleanName1 = name.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
                    var cleanName2 = cleanName1.replacingOccurrences(of: " ", with: "")
                    
                    if (!cleanName1.isEmpty && (!buildingFound) && !cleanKeyword1.isEmpty){
                        if (cleanName1.contains(cleanKeyword1)){
                            buildingFound = true
                        }
                    }
                    
                    if (!cleanName1.isEmpty && (!buildingFound) && !cleanKeyword2.isEmpty){
                        if (cleanName1.contains(cleanKeyword1)){
                            buildingFound = true
                        }
                    }
                    
                    
                    if (!cleanName2.isEmpty && (!buildingFound)){
                        
                    }
                    
                    
//                    if (cleanName1.contains())
                    
                    
                }
//                if (building.name)
                return buildingFound
            }
        }
      
        
        return results
    }
    
    private func buildingHasFeature(feature: BuildingFeature, building: Building) -> Bool{
        switch feature {
            case .accessible:
                return Bool(building.isAccessible ?? false)
            case .bikeParking:
                return Bool(building.isBikeParking ?? false)
            case .familyFriendly:
                return Bool(building.isFamilyFriendly ?? false)
            case .freeParking :
                return Bool(building.isFreeParking ?? false)
            case .guidedTour:
                return Bool(building.isGuidedTour ?? false)
            case .isNew:
                return Bool (building.isNew ?? false)
            case .oCTranspoNearby:
                return Bool(building.isOCTranspoNearby ?? false)
            case .openSaturday:
                return Bool(building.isOpenSaturday ?? false)
            case .openSunday:
                return Bool(building.isOpenSunday ?? false)
            case .paidParking:
                return Bool(building.isPaidParking ?? false)
            case .publicWashroom:
                return Bool(building.isPublicWashrooms ?? false)
            case .shuttleBus:
                return Bool(building.isShuttle ?? false)
            default:
                return false
            }
        return false
    }
    
}
