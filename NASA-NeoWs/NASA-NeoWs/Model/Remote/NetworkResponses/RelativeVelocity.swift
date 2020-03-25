//
//  RelativeVelocity.swift
//  NASA-NeoWs
//
//  Created by Apple on 16/03/2020.
//  Copyright © 2020 RR Inc. All rights reserved.
//

import Foundation

struct RelativeVelocity: Codable {
    let kmPerSecond: String
    let kmPerHour: String
    let milesPerHour: String

    enum CodingKeys: String, CodingKey {
        case kmPerSecond = "kilometers_per_second"
        case kmPerHour = "kilometers_per_hour"
        case milesPerHour = "miles_per_hour"
    }

    func toString() -> String {
        return String(format: "%.2f kilometers/hour", Double(kmPerHour)!)
    }
}
