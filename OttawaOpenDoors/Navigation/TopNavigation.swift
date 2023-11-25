//
//  TopNavigation.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-22.
//

import SwiftUI

enum TopNavigationMode {
    case defaultView
    case withBackButton
}

struct TopNavigation: View {
    @ObservedObject var appModel:AppModel
    
    
    var body: some View {
        HStack(alignment: .center){
            HStack{
                
                
                Image("ic_logo_new").resizable().frame(width: 50, height: 50)
                
                HStack{
                    Text(appModel.topBarTitle).foregroundStyle(.white)
                }
                
                Spacer()
                if (appModel.topBarShowTrailingComponents)
                {
                    HStack{
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 24)).onTapGesture {
//                                appModel.topbar
                            }
                        Image(systemName: "slider.vertical.3")
                            .font(.system(size: 24))
                    }.foregroundColor(.white)
                }
                
                
            }.padding(.horizontal, 16)
        }
        .background(COLORS.BRAND_COLOR)
    }
}

#Preview {
    TopNavigation(appModel: AppModel())
}
