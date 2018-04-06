//
//  CoreDataManager.swift
//  AdvanceCoreData
//
//  Created by Khaled Rahman Ayon on 03.04.18.
//  Copyright © 2018 DocDevs. All rights reserved.
//

import CoreData

struct CoreDataManager {
    static let shared = CoreDataManager()
    let persistanceContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AdvanceCoreDataModel")
        container.loadPersistentStores { (storeDesc, error) in
            if let err = error {
                fatalError("Loading of store failed: \(err)")
            }
        }
        return container
    }()
}
