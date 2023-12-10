//
//  Style.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-23.
//

import Foundation
import SwiftUI

struct COLORS {
    
    
    static let BRAND_COLOR = Color(red: 25/255.0, green: 73/255.0, blue: 137/255.0) //#194989
    static let BACKGROUND_COLOR2 = Color(red: 220/255.0, green: 222/255.0, blue: 228/255.0)
    static let BACKGROUND_COLOR = Color.white
    
    
    
    static let TOOLBAR_COLOR:Color = BRAND_COLOR
    static let LIGHT_TEXT_COLOR:Color = Color.white
    static let DARK_TEXT_COLOR:Color = Color.black
    static let DARK_TEXT_COLOR_LIGHT = Color.black.opacity(0.7)
    static let TEXT_BUTTON_BLUE:Color = .blue

    static let BUTTON_ENABLED_BORDER_COLOR = Color.blue
    static let BUTTON_DISABLE_BORDER_COLOR = Color.clear
    
    static let BUTTON_ENABLED_BG_COLOR = Color.white
    static let BUTTON_DISABLE_BG_COLOR = Color.gray.opacity(0.2)
    
    static let BUTTON_ENABLED_TEXT_COLOR = Color.blue
    static let BUTTON_DISABLED_TEXT_COLOR = Color.black.opacity(0.4)
   
    
    static let FAV_OVERLAY_BG_COLOR = Color(red: 1, green: 1, blue: 1,opacity: 0.8)
    static let FAV_OVERLAY_FILL_COLOR = BRAND_COLOR
    static let FAV_OVERLAY_STROKE_COLOR = BRAND_COLOR
    
    static let NAVIGATION_TINT_COLOR_DARK = BRAND_COLOR
    static let NAVIGATION_TINT_COLOR_LIGHT = Color(red: 215/255.0, green: 227/255.0, blue: 245/255.0)

    
   
}


struct STYLE_VARIABLES{
    static let SORT_BUTTON_CORNER_RADIUS:Double = 20.0
    static let CARD_VIEW_DEFAULT_CORDER_RADIUS:Double = 4
    static let CARD_VIEW_DEFAULT_SHADOW_COLOR:Color = .black.opacity(0.2)
    static let CARD_VIEW_DEFAULT_SHADOW_RADIUS:CGFloat = 2.0
    static let CARD_VIEW_DEFAULT_SHADOW_X:CGFloat = 2.0
    static let CARD_VIEW_DEFAULT_SHADOW_Y:CGFloat = 2.0
    
    

}
