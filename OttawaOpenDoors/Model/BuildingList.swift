//
//  BuildingResponse.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-24.
//

import Foundation

struct BuildingList: Codable {
    var language: String
    var version: Int
    var year: Int
    var buildings: [Building]
}

