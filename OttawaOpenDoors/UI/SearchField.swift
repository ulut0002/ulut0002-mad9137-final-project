//
//  SearchField.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-30.
//

import SwiftUI



struct SearchField: View {
    
    @Binding var searchText: String
     var searchTextHint: String
    @EnvironmentObject var appLanguageManager: AppLanguageManager


    var body: some View {
        HStack {
            TextField(searchTextHint.localizeString(string: appLanguageManager.locale.identifier), text: $searchText)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onChange(of: searchText){ oldValue, newValue in
                    self.searchText = newValue
                }

            Button(action: {
                self.searchText = ""
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
                    .padding(.trailing, 8)
            }
        }
    }
}
