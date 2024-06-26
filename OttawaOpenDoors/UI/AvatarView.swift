//
//  AvatarView.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-29.
//

import SwiftUI


// Source: https://ishtiz.com/swiftui/how-to-create-a-custom-avatar-in-swiftui
struct AvatarView: View {
    let image: Image
    let size: CGFloat
    let color:Color

    var body: some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: size, height: size)
            .cornerRadius(size / 2)
            .overlay(
                Circle()
                    .stroke(color, lineWidth: 3)
                    .frame(width: size, height: size)
            )

        
    }
}

