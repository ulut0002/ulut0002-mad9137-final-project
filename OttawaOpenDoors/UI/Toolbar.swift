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
                HStack(alignment: .center){
                    AvatarView(image:  Image("ic_logo"), size: 32, color:.white)
                
                    Text(localizedString(forKey:"Toolbar_Title"))
                        .bold()
                        .font(.title3)
                        .padding(.leading, 4)
                        .foregroundStyle(COLORS.LIGHT_TEXT_COLOR)
                               
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


