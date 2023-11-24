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

