//
//  MapView.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-22.
//

import SwiftUI

struct MapView: View {
    var body: some View {
        ZStack{
            Color.blue
            VStack(){
                TopNavigation()
                Text("Map View")
                Spacer()

                
            }
            .frame(maxHeight: .infinity)
   
        }
    }
}

#Preview {
    MapView()
}
