//
//  Date+Extras.swift
//  NASA-NeoWs
//
//  Created by Apple on 16/03/2020.
//  Copyright © 2020 RR Inc. All rights reserved.
//

import Foundation
extension Date {
    func toFormat(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
