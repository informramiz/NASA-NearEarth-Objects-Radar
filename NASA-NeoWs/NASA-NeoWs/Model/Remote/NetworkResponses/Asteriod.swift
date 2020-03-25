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
    
    static let keyTextAttrs: [NSAttributedString.Key:Any] = [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
    static let valueTextAttrs: [NSAttributedString.Key:Any] = [NSAttributedString.Key.foregroundColor: UIColor.gray]
    
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
        if !closeApproachData.isEmpty {
            text.append(closeApproachData[0].toString(keyAttrs: Asteriod.keyTextAttrs, valueAttrs: Asteriod.valueTextAttrs))
        }
        return text
    }
    
    private func toAttributedString(key: String, value: String, link: String? = nil) -> NSAttributedString {
        var valueTextAttrs: [NSAttributedString.Key:Any] = Asteriod.valueTextAttrs
        let text: NSMutableAttributedString = NSMutableAttributedString()
        if link != nil {
            valueTextAttrs[NSAttributedString.Key.link] = link
        }
        
        
        text.append(NSAttributedString(string: "\(key): ", attributes: Asteriod.keyTextAttrs))
        text.append(NSAttributedString(string: "\t\(value)\n", attributes: valueTextAttrs))
        return text
    }
}

extension Asteriod {
    func toCoreDataAsteriod() -> CoreDataAsteriod {
        let savedAsteriod = CoreDataAsteriod(context: DataController.shared.viewContext)
        savedAsteriod.id = id
        savedAsteriod.name = name
        savedAsteriod.neoReferenceId = neoReferenceId
        savedAsteriod.absoluteMagnitude = absoluteMagnitude
        savedAsteriod.estimatedDiameter = estimatedDiameter.toString()
        savedAsteriod.primaryDataAttributedString = primaryDataAttributedString
        savedAsteriod.secondaryDataAttributedString = secondaryDataAttributedString
        return savedAsteriod
    }
}
