//
//  CoreDataAsteriod.swift
//  NASA-NeoWs
//
//  Created by Apple on 25/03/2020.
//  Copyright © 2020 RR Inc. All rights reserved.
//

import Foundation
import CoreData

extension CoreDataAsteriod {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        saveDate = Date()
    }
}
