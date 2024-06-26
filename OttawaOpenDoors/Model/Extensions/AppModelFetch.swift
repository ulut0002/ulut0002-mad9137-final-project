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
        }
        return nil
    }
    
    
    func changeDataLanguge() {
        DispatchQueue.main.async {
            self.applyFilters()

        }
        
        DispatchQueue.main.async {
            
            self.filterBookmarks()
        }
        
    }
    
    
    @MainActor
    func retrieve() async throws{
        
        self.fetchStatus = .fetching
        
        
        var englishBuildingsTemp:[Building] = []
        var frenchBuildingsTemp:[Building] = []
        
        
        readUserConfigurationFromStorage() //updates model
        let savedBookmarks:[BookmarkInfo] = readBookmarksFromStorage()
        
        
        
        do{
            
            
            
            let fetchedBuildingListArray = try await self.fetchData()
            
            
            if let fetchedBuildingList = fetchedBuildingListArray?[0].buildings{
                englishBuildingsTemp =  fetchedBuildingList
            }
            
            if let fetchedBuildingList = fetchedBuildingListArray?[1].buildings{
                frenchBuildingsTemp = fetchedBuildingList
            }
            
            // mark favorites as bulk
            for savedBookmark in savedBookmarks {
                if let idx = englishBuildingsTemp.firstIndex(where: {$0.id == savedBookmark.id}){
                    englishBuildingsTemp[idx].bookmarkInfo = savedBookmark
                }
                if let idx = frenchBuildingsTemp.firstIndex(where: {$0.id == savedBookmark.id}){
                    frenchBuildingsTemp[idx].bookmarkInfo = savedBookmark
                }
            }
            
//            DispatchQueue.main.async{
                
                self.buildingsMaster[.english] =   englishBuildingsTemp
                self.buildingMasterEn =  englishBuildingsTemp
                
                
                
                self.buildingsMaster[.french] =  frenchBuildingsTemp
                self.buildingMasterFr = frenchBuildingsTemp
                
                self.favoritesMaster = savedBookmarks
                self.applyFilters()
                self.filterBookmarks()
                self.fetchStatus = .idle

            
            
            
        }catch{
            self.fetchStatus = .error
            
            print("Error: \(error.localizedDescription)")
        }
    }
}
