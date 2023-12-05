//
//  FeatureFilterItem.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-12-02.
//

import SwiftUI

struct FeatureFilterItem: View {
    @Binding var draftFeature: Feature
    
    
    var body: some View {
        HStack{
            Image(systemName: draftFeature.option.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 32, height: 32)
            
            Text(draftFeature.option.translation).font(.body)
            Spacer()
            Toggle("", isOn: $draftFeature.selected)
                .toggleStyle(.switch)
        }.onAppear(){
            // do nothing
        }
    }
}

