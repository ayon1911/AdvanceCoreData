//
//  ViewController.swift
//  AdvanceCoreData
//
//  Created by Khaled Rahman Ayon on 02.04.18.
//  Copyright © 2018 DocDevs. All rights reserved.
//

import UIKit
import CoreData

class CompaniesVC: UITableViewController, CreateCompanyDelegate {

    //MARK:- variables
    var companies = [Company]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        additionalNavBarSetup()
        setupTableView()
        view.backgroundColor = .tableviewBackgroudColor
        
        fetchCompanies()
    }
    
    //MARK:- setup
    fileprivate func additionalNavBarSetup () {
        navigationItem.title = "Companies"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(handleAddCompany))
    }
    
    func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: COMPANY_CELL_ID)
    }
    
    //MARK:- handel functionalities
    @objc private func handleAddCompany() {
        let createCompanyVC = CreateCompanyVC()
        let navController = CustomNavController(rootViewController: createCompanyVC)
        createCompanyVC.delegate = self
        present(navController, animated: true, completion: nil)
    }
    
    func didAddCompany(company: Company) {
        companies.append(company)
        let index = IndexPath(row: companies.count - 1, section: 0)
        tableView.insertRows(at: [index], with: .automatic)
    }
    
    private func fetchCompanies(){
        let context = CoreDataManager.shared.persistanceContainer.viewContext
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
        do {
            let companies = try context.fetch(fetchRequest)
            companies.forEach { (company) in
                print(company.name ?? "")
            }
            self.companies = companies
            self.tableView.reloadData()
        } catch let err {
            debugPrint(err as Any)
        }
    }
}
//Tableview Extensions
extension CompaniesVC {
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .headerViewColor
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: COMPANY_CELL_ID, for: indexPath)
        let company = companies[indexPath.row]
        cell.backgroundColor = .cellBackgroundColor
        if let name = company.name, let founded = company.founded {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy"
            let formatedDate = dateFormatter.string(from: founded)
            cell.textLabel?.text = "\(name) - Founded \(formatedDate)"
            
        } else {
            cell.textLabel?.text = company.name
        }
        cell.textLabel?.font = UIFont(name: "AvenirNext-Regular", size: 18.0)
        cell.textLabel?.textColor = .white
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: deleteRowAction)
        deleteAction.backgroundColor = UIColor.deleteColor
        let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: editRowAction)
        editAction.backgroundColor = UIColor.editColor
        return [deleteAction, editAction]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.textLabel?.textColor = .black
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.textLabel?.textColor = .white
    }
    //MARK:- cell actions(delete, edit)
    private func deleteRowAction(action: UITableViewRowAction, indexPath: IndexPath) {
        let company = self.companies[indexPath.row]
        self.companies.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
        
        let context = CoreDataManager.shared.persistanceContainer.viewContext
        context.delete(company)
        
        do {
            try context.save()
        } catch let err {
            debugPrint(err as Any)
        }
    }
    
    private func editRowAction(action: UITableViewRowAction, indexPath: IndexPath) {
        let editCompanyVC = CreateCompanyVC()
        editCompanyVC.delegate = self
        editCompanyVC.company = companies[indexPath.row]
        let navController = UINavigationController(rootViewController: editCompanyVC)
        present(navController, animated: true, completion: nil)
    }
    
    func didEditCompany(company: Company) {
        let row = companies.index(of: company)
        let reloadIndexPath = IndexPath(row: row!, section: 0)
        tableView.reloadRows(at: [reloadIndexPath], with: UITableViewRowAnimation.middle)
    }
}

