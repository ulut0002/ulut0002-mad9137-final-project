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
             print("jere")
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
    
    
    func retrieve(){
        // first load local data


        let storageAllFavorites = readFromStorage(forKey: CONFIGURATION.STORAGE_KEY_SAVED_BUILDINGS)

        // fetch data
        Task{
            do{
                
                
                let fetchedBuildingListArray = try await fetchData()
           
                if let fetchedBuildingList = fetchedBuildingListArray?[0].buildings{
                    for building in fetchedBuildingList {

                        masterBuildings.append(building)
                    }
                }
                
                print(masterBuildings.count)
//
//                
              
                
//                buildings = masterBuildings
             
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
