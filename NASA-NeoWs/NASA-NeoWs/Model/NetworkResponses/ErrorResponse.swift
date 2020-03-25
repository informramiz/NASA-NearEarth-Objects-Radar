//
//  ErrorResponse.swift
//  NASA-NeoWs
//
//  Created by Apple on 25/03/2020.
//  Copyright © 2020 RR Inc. All rights reserved.
//

import Foundation

struct ErrorInfo: Codable {
    let code: String?
    let message: String?
}
struct ErrorResponse: Codable {
    let error: ErrorInfo
}

extension ErrorResponse: LocalizedError {
    var errorDescription: String? {
        return error.message ?? ""
    }
}
