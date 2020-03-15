//
//  Asteriods.swift
//  NASA-NeoWs
//
//  Created by Apple on 16/03/2020.
//  Copyright © 2020 RR Inc. All rights reserved.
//

import Foundation
struct Asteriods: Codable {
    let links: Links
    let elementCount: Int
    let nearEarthObjects: [String: [Asteriod]]
    
    enum CodingKeys: String, CodingKey {
        case links
        case elementCount = "element_count"
        case nearEarthObjects = "near_earth_objects"
    }
}
