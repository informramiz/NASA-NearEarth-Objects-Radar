//
//  Asteriod.swift
//  NASA-NeoWs
//
//  Created by Apple on 16/03/2020.
//  Copyright © 2020 RR Inc. All rights reserved.
//

import Foundation
struct Asteriod: Codable {
    let id: String
    let name: String
    let neoReferenceId: String
    let nasaJPLUrl: String
    let absoluteMagnitude: Double
    let estimatedDiameter: [String: [String:Double]]
    let isPotentiallyHazardousAsteriod: Bool
    let closeApproachData: [CloseApproachData]
    let isSentryObject: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case neoReferenceId = "neo_reference_id"
        case nasaJPLUrl = "nasa_jpl_url"
        case absoluteMagnitude = "absolute_magnitude_h"
        case estimatedDiameter = "estimated_diameter"
        case isPotentiallyHazardousAsteriod = "is_potentially_hazardous_asteroid"
        case closeApproachData = "close_approach_data"
        case isSentryObject = "is_sentry_object"
    }
}
