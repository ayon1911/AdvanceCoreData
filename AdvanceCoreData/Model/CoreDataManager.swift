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
    
    func createEmployee(employeeName: String, birthDay: Date, employeeType: String, company: Company) -> (Employee?, Error?) {
        let context = persistanceContainer.viewContext
        let employee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context) as! Employee
        employee.setValue(employeeName, forKey: "name")
        employee.company = company
        employee.type = employeeType
        
        let employeeInfo = NSEntityDescription.insertNewObject(forEntityName: "EmployeeInfo", into: context) as! EmployeeInfo
        employeeInfo.taxId = "456"
        employee.employeeInfo = employeeInfo
        employee.employeeInfo?.dateOfBirth = birthDay
        
        do {
            try context.save()
            return (employee, nil)
        } catch let err {
            debugPrint(err as Any)
            return (nil, err)
        }
    }
}
