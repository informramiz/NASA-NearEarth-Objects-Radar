//
//  MissDistance.swift
//  NASA-NeoWs
//
//  Created by Apple on 16/03/2020.
//  Copyright © 2020 RR Inc. All rights reserved.
//

import Foundation

struct MissDistance: Codable {
    let astronomical: String
    let lunar: String
    let kilometers: String
    let miles: String
    
    func toString() -> String {
        return String(format: "%.2f kilometers", Double(kilometers)!)
    }
}
