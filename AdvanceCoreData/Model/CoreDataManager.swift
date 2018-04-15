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
    
    func fetchCompanies() -> [Company] {
        let context = persistanceContainer.viewContext
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
        do {
            let companies = try context.fetch(fetchRequest)
            return companies
        } catch let err {
            debugPrint(err as Any)
            return []
        }
    }
    
    func batchDelete(completion: () -> ()) {
        let context = persistanceContainer.viewContext
        let deleteBatchRequest = NSBatchDeleteRequest(fetchRequest: Company.fetchRequest())
        do {
            try context.execute(deleteBatchRequest)
            try context.save()
            completion()
        } catch let err {
            debugPrint(err as Any)
        }
    }
}
