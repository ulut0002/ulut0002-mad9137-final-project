//
//  LanguageSelection.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-22.
//

import SwiftUI

struct LanguageSelectionView: View {
    @State var selectedLanguage: Language = .english
    var body: some View {
        HStack{
            Text("Language").bold()
            Spacer()
            Picker("", selection: $selectedLanguage){
                Text("English").tag(Language.english)
                Text("French").tag(Language.french)
            }
        }
        
        
    }
}

#Preview {
    LanguageSelectionView()
}
