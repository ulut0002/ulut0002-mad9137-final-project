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
    var title: String = ""
    var body: some View {
        HStack{
            Text("Top Navigation")
        }
        .background(Color.yellow)
        .frame(maxWidth: .infinity)
        .frame(height: 50)
    }
}

#Preview {
    TopNavigation()
}
