//
//  Links.swift
//  NASA-NeoWs
//
//  Created by Apple on 16/03/2020.
//  Copyright © 2020 RR Inc. All rights reserved.
//

import Foundation
struct Links: Codable {
    let prev: String?
    let next: String?
    let current: String
    
    enum CodingKeys: String, CodingKey {
        case prev
        case next
        case current = "self"
    }
}
