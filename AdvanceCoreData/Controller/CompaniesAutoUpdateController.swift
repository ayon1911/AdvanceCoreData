//
//  CompaniesAutoUpdateController.swift
//  AdvanceCoreData
//
//  Created by Khaled Rahman Ayon on 26.04.18.
//  Copyright © 2018 DocDevs. All rights reserved.
//

import UIKit
import CoreData

class CompaniesAutoUpdateController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    //MARK:- Variables
    lazy var fetchedResultsController: NSFetchedResultsController<Company> = {
        let context = CoreDataManager.shared.persistanceContainer.viewContext
        let request: NSFetchRequest<Company> = Company.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "name", ascending: true)
        ]
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: "name", cacheName: nil)
        frc.delegate = self
        do {
            try frc.performFetch()
        } catch let err {
            debugPrint(err as Any)
        }
        
        return frc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Companies Auto update"
        tableView.backgroundColor = UIColor.tableviewBackgroudColor
        
        navigationItem.leftBarButtonItems = [
            UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(handleAdd)),
            UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(handleDelete))
        ]
        
        tableView.register(CompanyCell.self, forCellReuseIdentifier: COMPANY_CELL_ID)
        
//        fetchedResultsController.fetchedObjects?.forEach({ (company) in
//            print(company.name ?? "")
//        })
        ApiService.shared.downloadCompaniesFromServer()
    }
    
    @objc private func handleAdd() {
        let context = CoreDataManager.shared.persistanceContainer.viewContext
        let company = Company(context: context)
        company.name = "Honda"
        try? context.save()
    }
    
    @objc private func handleDelete() {
        let request: NSFetchRequest<Company> = Company.fetchRequest()
//        request.predicate = NSPredicate(format: "name CONTAINS %@", "H")
        let context = CoreDataManager.shared.persistanceContainer.viewContext
        let companiesWithH = try? context.fetch(request)
        
        companiesWithH?.forEach({ (company) in
            context.delete(company)
        })
        try? context.save()
    }
}

extension CompaniesAutoUpdateController {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        case .move:
            break
        case .update:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .fade)
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, sectionIndexTitleForSectionName sectionName: String) -> String? {
        return sectionName
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = LeftIndentedLabel()
        label.backgroundColor = UIColor.headerViewColor
        label.text = fetchedResultsController.sectionIndexTitles[section]
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections![section].numberOfObjects
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: COMPANY_CELL_ID, for: indexPath) as! CompanyCell
        
        let company = fetchedResultsController.object(at: indexPath)
        cell.company = company
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
}





