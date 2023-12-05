//
//  CategoryFilterItem.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-12-02.
//

import SwiftUI

struct CategoryFilterItem: View {
    @Binding var draftCategory: Category


    var body: some View {
        HStack{
            Image(systemName: draftCategory.option.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 32, height: 32)
            
            Text(draftCategory.option.translation).font(.body)
            Spacer()
            Toggle("", isOn: $draftCategory.selected)
                .toggleStyle(.switch)
        }.onAppear(){
            // do nothing
        }
    }
}

