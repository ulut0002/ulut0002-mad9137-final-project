//
//  AppModelFetch.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-24.
//

import Foundation



extension AppModel{
    // Asynchronous method to fetch country data from the specified URL
    private func fetchData() async throws -> [BuildingList]?{
        if let url =  Bundle.main.url(forResource: "buildings", withExtension: "json") {
            do{
                let data = try Data(contentsOf: url)
                let response = try JSONDecoder().decode([BuildingList].self,
                                                        from: data)
                return response
            }catch{
                print("Error: \(error)")
                return nil
            }
        }else{
            print("failed ")
        }
        return nil
    }
    
    
    private func retrieveCategories(buildingList: [Building]) -> [Category]{
        var tempArray:[Category] = []
        for building in buildingList {
            if let id = building.categoryId, let definition = building.category {
                let newCategory = Category(id: id, definition: definition)
                if (!tempArray.contains(newCategory)){
                    tempArray.append(newCategory)
                }
            }
        }
        return tempArray
    }
    
    
    @MainActor func retrieve(){
        // first load local data

        DispatchQueue.main.async {
            self.fetchStatus = .reFetching
        }

        let storageAllFavorites = readFromStorage(forKey: CONFIGURATION.STORAGE_KEY_SAVED_BUILDINGS)
     
    
        // fetch data
        Task{
            var englishBuildingsTemp:[Building] = []
            var frenchBuildingsTemp:[Building] = []
            

            do{
                let fetchedBuildingListArray = try await fetchData()
           
                if let fetchedBuildingList = fetchedBuildingListArray?[0].buildings{
                   englishBuildingsTemp = fetchedBuildingList
                }
                
                if let fetchedBuildingList = fetchedBuildingListArray?[1].buildings{
                    frenchBuildingsTemp = fetchedBuildingList
                }
                
                // find categories in English and French separately
                let categoriesEnTemp = retrieveCategories(buildingList: englishBuildingsTemp)
                let categoriesFrTemp = retrieveCategories(buildingList: frenchBuildingsTemp)

             
                
                DispatchQueue.main.async {
//                    self.masterBuildingList[.english] = englishBuildingsTemp
//                    self.filteredBuildings = englishBuildingsTemp
                   
                }
                
                DispatchQueue.main.async {
//                    self.masterBuildingList[.french] = frenchBuildingsTemp
                }
                
                DispatchQueue.main.async {
                    self.fetchStatus = .idle
                }
                
                
               
             
            }catch{
                DispatchQueue.main.async {
                    self.fetchStatus = .error
                }
                print("Error: \(error.localizedDescription)")
            }
        }
        // update current daa
    }
    
    private func readFromStorage(forKey: String) -> [Building] {
       if let savedData = UserDefaults.standard.data(forKey: forKey),
          let decodedArray = try? JSONDecoder().decode([Building].self, from: savedData){
           return decodedArray
       } else {
           // Handle the case where the array of objects couldn't be retrieved or decoded
//           print("Unable to retrieve or decode the array of objects from UserDefaults.")
           return []
       }
   }
}
