//
//  CompaniesVC+UiTableView.swift
//  AdvanceCoreData
//
//  Created by Khaled Rahman Ayon on 15.04.18.
//  Copyright © 2018 DocDevs. All rights reserved.
//

import UIKit

extension CompaniesVC {
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .headerViewColor
        return view
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "No Companies available"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-Medium", size: 20.0)
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return companies.count == 0 ? 150.0 : 0.0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: COMPANY_CELL_ID, for: indexPath) as! CompanyCell
        
        let company = companies[indexPath.row]
        cell.company = company
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let employeesVC = EmployeesVC()
        let company  = companies[indexPath.row]
        employeesVC.company = company
        navigationController?.pushViewController(employeesVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: deleteRowAction)
        deleteAction.backgroundColor = UIColor.deleteColor
        let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: editRowAction)
        editAction.backgroundColor = UIColor.editColor
        return [deleteAction, editAction]
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
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
}
