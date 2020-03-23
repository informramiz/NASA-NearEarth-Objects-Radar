//
//  Diameter.swift
//  NASA-NeoWs
//
//  Created by Apple on 23/03/2020.
//  Copyright © 2020 RR Inc. All rights reserved.
//

import Foundation
struct Diameter: Codable {
    let minEstimatedDiameter: Double
    let maxEstimatedDiameter: Double
    
    enum CodingKeys: String, CodingKey {
        case minEstimatedDiameter = "estimated_diameter_min"
        case maxEstimatedDiameter = "estimated_diameter_max"
    }
    
    func toString() -> String {
        return String(format: "Min: %.2f \tMax: %.2f", minEstimatedDiameter, maxEstimatedDiameter)
    }
}
