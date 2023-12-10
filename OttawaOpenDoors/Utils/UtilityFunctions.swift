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

func localizedString(forKey key: String, parameters: CVarArg...) -> String {
    let formatString = NSLocalizedString(key, comment: "")
    return String(format: formatString, arguments: parameters)
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


// from chatGPT + modifications

func formatDate(_ dateString1: String, _ dateString2: String, locale: Locale ) -> String?{
    //
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    if let date1 = dateFormatter.date(from: dateString1), let date2=dateFormatter.date(from: dateString2){
        let outputFormatter = DateFormatter()
        
        outputFormatter.locale = locale
        outputFormatter.dateFormat = "EEEE, MMMM d"
        let dateValue =  outputFormatter.string(from: date1)
        
        outputFormatter.dateFormat = "HH:mm"
        let openingHour = outputFormatter.string(from: date1)
        let closingHour = outputFormatter.string(from: date2)
        
        
        let value =  localizedString(forKey: "Building_View_Opening_Hours_Text", parameters: dateValue, openingHour, closingHour)


        return value

    }
    return nil
}



// from chatGPT
func getCurrentLanguageCode() -> String {
    let preferredLanguageCode = Locale.preferredLanguages.first
    return preferredLanguageCode ?? CONFIGURATION.LANG_EN
}


func findBestMatchingLanguageCode() -> String {
    // https://www.ibabbleon.com/iOS-Language-Codes-ISO-639.html
    let langCode = getCurrentLanguageCode()
    if langCode.starts(with: "en"){
        return CONFIGURATION.LANG_EN
    }
    
    if (langCode.starts(with: "fr")){
        return CONFIGURATION.LANG_FR
    }
    
    return CONFIGURATION.LANG_EN
 
}


