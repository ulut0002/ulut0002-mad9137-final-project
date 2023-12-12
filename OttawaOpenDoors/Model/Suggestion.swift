//
//  Suggestion.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-12-11.
//

import Foundation
import Firebase
import FirebaseFirestore

struct Suggestion: Identifiable, Codable {
    var id: String {
        return name
    }
    var name: String = ""
    var description: String = ""
    var category: String = ""
    
    
    func toFirestore() throws -> [String: Any] {
           let encoder = Firestore.Encoder()
           return try encoder.encode(self)
       }
}
