//
//  UtilityFunctions.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-24.
//

import Foundation

func parseDate(dateTxt: String) -> Date?{
    let dateFormatter = DateFormatter()
    
    // Attempt 1
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    if let date = dateFormatter.date(from: dateTxt) {
        return date
    }
    
    // Attempt 2
    dateFormatter.dateFormat = "yyyy-MM-dd"
    if let date = dateFormatter.date(from: dateTxt) {
        return date
    }

    return nil
}





func searchText(source: String?, lookFor: String?) -> Bool{
    var nameFound = false
    
    if let source = source, let lookFor = lookFor {
        let sourceClean1 = source.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        let sourceClean2 = sourceClean1.replacingOccurrences(of: " ", with: "")
        
        let lookForClean1 = lookFor.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        let lookForClean2 = lookForClean1.replacingOccurrences(of: " ", with: "")
        
        var sourceArray: [String] = []
        sourceArray.append(sourceClean1)
        sourceArray.append(sourceClean2)
        
        var lookForArray: [String] = []
        lookForArray.append(lookForClean1)
        lookForArray.append(lookForClean2)
        
        for txt1 in sourceArray {
            for txt2 in lookForArray {
                if (!txt1.isEmpty && !txt2.isEmpty){
                    if (txt1.contains(txt2)){
                        nameFound = true
                        return true
                    }
                }
            }
        }
    }
    

    return nameFound
}
