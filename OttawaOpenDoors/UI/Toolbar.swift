//
//  Toolbar.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-12-04.
//

import SwiftUI

struct Toolbar: View {
    var body: some View {
        Label(
            title: {
                HStack{
                    AvatarView(image:  Image("ic_logo"), size: 32)
                    Text("Ottawa Open Doors").bold().font(.title3)
                        .padding(.leading, 4)
                    Spacer()
                }.padding(.vertical, 12)
            },
            icon: { Image(systemName: "42.circle") }

        ).labelStyle(TitleOnlyLabelStyle())
        
    }
}

#Preview {
    Toolbar()
}


