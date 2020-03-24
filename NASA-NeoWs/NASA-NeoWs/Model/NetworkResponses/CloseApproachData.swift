//
//  CloseApproachData.swift
//  NASA-NeoWs
//
//  Created by Ramiz on 16/03/2020.
//  Copyright © 2020 RR Inc. All rights reserved.
//

import Foundation
import UIKit

struct CloseApproachData: Codable {
    let closeApproachDate: String
    let closeApproachDateFull: String?
    let epochDateCloseApproach: Int64
    let relativeVelocity: RelativeVelocity
    let missDistance: MissDistance
    let orbitingBody: String
    
    enum CodingKeys: String, CodingKey {
        case closeApproachDate = "close_approach_date"
        case closeApproachDateFull = "close_approach_date_full"
        case epochDateCloseApproach = "epoch_date_close_approach"
        case relativeVelocity = "relative_velocity"
        case missDistance = "miss_distance"
        case orbitingBody = "orbiting_body"
    }
    
    func toString(keyAttrs: [NSAttributedString.Key:Any], valueAttrs: [NSAttributedString.Key: Any]) -> NSAttributedString{
        
        let toAttributedString = { (key: String, value: String) -> NSAttributedString in
            let text = NSMutableAttributedString()
            text.append(NSAttributedString(string: "\(key): ", attributes: keyAttrs))
            text.append(NSAttributedString(string: "\t\(value)\n", attributes: valueAttrs))
            return text
        }
        
        let text = NSMutableAttributedString()
        text.append(toAttributedString("Closest Approach Date", closeApproachDateFull != nil ? closeApproachDateFull! : closeApproachDate))
        text.append(toAttributedString("Relative Velocity", "\(relativeVelocity.toString())"))
        text.append(toAttributedString("Miss Distance", "\(missDistance.toString())"))
        text.append(toAttributedString("Orbiting Body", orbitingBody))
        return text
    }
    
    
}
