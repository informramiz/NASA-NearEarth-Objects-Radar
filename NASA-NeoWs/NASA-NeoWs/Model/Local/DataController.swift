//
//  DataController.swift
//  NASA-NeoWs
//
//  Created by Apple on 25/03/2020.
//  Copyright © 2020 RR Inc. All rights reserved.
//

import Foundation
import CoreData
class DataController {
    static var shared = DataController()
    
    private let persistentcontainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        return persistentcontainer.viewContext
    }
    
    private init() {
        persistentcontainer = NSPersistentContainer(name: "NASA-Neos")
    }
    
    func load() {
        persistentcontainer.loadPersistentStores { (storeDescription, error) in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
        }
    }
}
