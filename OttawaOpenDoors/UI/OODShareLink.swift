//
//  OODShareLink.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-12-11.
//

import SwiftUI

struct OODShareLink: View {
    var building: Building
    var body: some View {
        ShareLink(item: building.name ?? "",
                  subject: Text(building.name ?? ""),
                  message: Text(building.address ?? ""),
                  preview:
                    SharePreview(
                        building.name ?? "",
                        image: Image(building.imageResourceName))
        ) {
            Image(systemName: "square.and.arrow.up")
                .opacity(1)
                .foregroundStyle(COLORS.FAV_OVERLAY_STROKE_COLOR)
                .padding(.trailing, 8)
        }
    }
}
