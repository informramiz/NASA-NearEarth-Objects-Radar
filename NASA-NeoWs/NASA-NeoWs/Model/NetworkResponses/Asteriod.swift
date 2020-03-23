//
//  Asteriod.swift
//  NASA-NeoWs
//
//  Created by Apple on 16/03/2020.
//  Copyright © 2020 RR Inc. All rights reserved.
//

import Foundation
import UIKit
struct Asteriod: Codable {
    let id: String
    let name: String
    let neoReferenceId: String
    let nasaJPLUrl: String
    let absoluteMagnitude: Double
    let estimatedDiameter: EstimatedDiameter
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
    
    var primaryDataAttributedString: NSAttributedString {
        let text: NSMutableAttributedString = NSMutableAttributedString()
        text.append(toAttributedString(key: "Name", value: name))
        text.append(toAttributedString(key: "NEO Reference Id", value: neoReferenceId))
        text.append(toAttributedString(key: "NASA JPL URL", value: nasaJPLUrl, link: nasaJPLUrl))
        text.append(toAttributedString(key: "Absolute Magnitude", value: String(format: "%.2f", absoluteMagnitude)))
        text.append(toAttributedString(key: "is Potentionally Hazardous", value: "\(isPotentiallyHazardousAsteriod)"))
        return text
    }
    
    var secondaryDataAttributedString: NSAttributedString {
        let text: NSMutableAttributedString = NSMutableAttributedString()
        text.append(toAttributedString(key: "Estimated Diameter", value: estimatedDiameter.toString()))
        text.append(toAttributedString(key: "Approach Date", value: closeApproachData[0].closeApproachDate))
        return text
    }
    
    private func toAttributedString(key: String, value: String, link: String? = nil) -> NSAttributedString {
        let text: NSMutableAttributedString = NSMutableAttributedString()
        let keyTextAttrs: [NSAttributedString.Key:Any] = [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        var valueTextAttrs: [NSAttributedString.Key:Any] = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        if link != nil {
            valueTextAttrs[NSAttributedString.Key.link] = link
        }
        
        
        text.append(NSAttributedString(string: "\(key): ", attributes: keyTextAttrs))
        text.append(NSAttributedString(string: "\t\(value)\n", attributes: valueTextAttrs))
        return text
    }
}
