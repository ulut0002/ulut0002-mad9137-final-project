//
//  SearchField.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-30.
//

import SwiftUI



struct SearchField: View {
    
    @Binding var searchText: String

    var body: some View {
        HStack {
            TextField("Search Keyword", text: $searchText)
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
