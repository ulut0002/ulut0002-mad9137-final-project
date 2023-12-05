//
//  Style.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-23.
//

import Foundation
import SwiftUI

struct COLORS {
    static var BRAND_COLOR = Color(red: 25/255, green: 73/255, blue: 137/255) //#194989
//    static var BRAND_COLOR = Color(red: 197/255, green: 58/255, blue: 40/255) //#  #c53a28
    static let BACKGROUND_COLOR = Color(red: 220/255, green: 222/255, blue: 228/255)

    static let BUTTON_ENABLED_BORDER_COLOR = Color.blue
    static let BUTTON_DISABLE_BORDER_COLOR = Color.clear
    
    static let BUTTON_ENABLED_BG_COLOR = Color.white
    static let BUTTON_DISABLE_BG_COLOR = Color.gray.opacity(0.2)
    
    static let BUTTON_ENABLED_TEXT_COLOR = Color.blue
    static let BUTTON_DISABLED_TEXT_COLOR = Color.black.opacity(0.4)
   
    
    static let FAV_OVERLAY_BG_COLOR = Color(red: 1, green: 1, blue: 1,opacity: 0.8)
    static let FAV_OVERLAY_FILL_COLOR = BRAND_COLOR
    static let FAV_OVERLAY_STROKE_COLOR = BRAND_COLOR
}


struct STYLE_VARIABLES{
    static let SORT_BUTTON_CORNER_RADIUS:Double = 20.0

}
