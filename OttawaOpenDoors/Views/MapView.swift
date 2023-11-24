//
//  MapView.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-22.
//

import SwiftUI

struct MapView: View {
    var appModel:AppModel

    var body: some View {
        ZStack{
            Color.blue
            VStack(){
                TopNavigation(appModel: appModel)
                Text("Map View")
                Spacer()

                
            }
            .frame(maxHeight: .infinity)
   
        }
    }
}

#Preview {
    MapView(appModel: AppModel())
}
