//
//  CategoryFilterItem.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-12-02.
//

import SwiftUI

struct CategoryFilterItem: View {
    @Binding var draftCategory: Category
    @EnvironmentObject var appLanguageManager: AppLanguageManager


    var body: some View {
        HStack{
            Image(systemName: draftCategory.option.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: CONFIGURATION.FILTER_VIEW_ICON_WIDTH, height: CONFIGURATION.FILTER_VIEW_ICON_HEIGHT)
            
            Text(draftCategory.option.translate(appLanguageManager.locale.identifier)).font(.body)
            Spacer()
            Toggle("", isOn: $draftCategory.selected)
                .toggleStyle(.switch)
        }.onAppear(){
            // do nothing
        }.tint(COLORS.BRAND_COLOR)
    }
}

