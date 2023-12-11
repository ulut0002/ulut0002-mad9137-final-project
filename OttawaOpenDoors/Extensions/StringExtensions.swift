//
//  StringExtensions.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-24.
//

import Foundation


// https://stackoverflow.com/questions/26707352/how-to-split-filename-from-file-extension-in-swift

extension String {
    
    func fileName() -> String {
        return URL(fileURLWithPath: self).deletingPathExtension().lastPathComponent
    }
    
    func fileExtension() -> String {
        return URL(fileURLWithPath: self).pathExtension
    }
    
    func cropText() -> String{
        
        if (self.count > CONFIGURATION.BUILDING_DESCRIPTION_SHORT_DESCRIPTION_LENGTH){
            return self.prefix(CONFIGURATION.BUILDING_DESCRIPTION_SHORT_DESCRIPTION_LENGTH) + "..."
        }else{
            return self
        }
    }
    
    func localizeString(string: String,  parameters: CVarArg...) -> String {
        let path = Bundle.main.path(forResource: string, ofType: "lproj")
        if let path = path {
            let bundle = Bundle(path: path)
            let formatString = NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
            return String(format: formatString, arguments: parameters)
        }else{
        }
        return "Wow"
        
        
        
    }
}
