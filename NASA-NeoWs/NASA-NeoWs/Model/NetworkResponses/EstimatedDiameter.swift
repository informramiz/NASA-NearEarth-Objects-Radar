//
//  EstimatedDiameter.swift
//  NASA-NeoWs
//
//  Created by Apple on 23/03/2020.
//  Copyright © 2020 RR Inc. All rights reserved.
//

import Foundation
struct EstimatedDiameter: Codable {
    let kilometers: Diameter
    
    func toString() -> String {
        return kilometers.toString()
    }
}
