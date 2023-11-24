//
//  AppModelFetch.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-24.
//

import Foundation

extension AppModel{
    // Asynchronous method to fetch country data from the specified URL
    private func fetchData() async throws -> [Building] {
        if let url = URL(string: CONFIGURATION.DATA_SOURCES[0]) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let (data, _) = try await URLSession.shared.data(for: request)

            let decoder = JSONDecoder()
            let result = try decoder.decode([Building].self, from: data)
            return result
        }
        return []
    }
    
    
    func retrieve(){
        // first load local data

        let storageAllBuildings = readFromStorage(forKey: CONFIGURATION.STORAGE_KEY_ALL_BUILDINGS)
        let storageAllFavorites = readFromStorage(forKey: CONFIGURATION.STORAGE_KEY_SAVED_BUILDINGS)
        
//        masterBuildings = storageAllBuildings
//        masterFavoriteBuildings = storageAllFavorites
        
        
        
        // fetch data
        Task{
            do{
                
                // update current data first
                
            
                let fetchedBuildingList = try await fetchData()
                for building in fetchedBuildingList {
                    // find it in masterbuilding lost
                    masterBuildings.append(building)
                    print(building.nameEN ?? "name")
                }
                
                buildings = masterBuildings
             
            }catch{
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
