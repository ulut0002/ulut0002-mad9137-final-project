//
//  SavedView.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-22.
//

import SwiftUI

struct SavedView: View {
    var body: some View {
        ZStack{
            Color.green
            VStack(){
                TopNavigation()
                Text("Saved View")
                Spacer()
   
            }
        }
    }
}

#Preview {
    SavedView()
}
