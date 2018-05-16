//
//  EmployeesVC.swift
//  AdvanceCoreData
//
//  Created by Khaled Rahman Ayon on 15.04.18.
//  Copyright © 2018 DocDevs. All rights reserved.
//

import UIKit
import CoreData

class EmployeesVC: UITableViewController {
    //MARK:- variables
    var company: Company?
    var employees = [Employee]()
    var allEmployees = [[Employee]]()
    
    var employeeTypes = [
        EmployeeType.Executive.rawValue,
        EmployeeType.Management.rawValue,
        EmployeeType.Staff.rawValue
    ]
    
    override func viewDidLoad() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: EMPLOYEE_CELL_ID)
        super.viewDidLoad()
        fetchEmployees()
        setupUi()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = company?.name
        
    }
    
    //MARK:- setup
    private func setupUi() {
        view.backgroundColor = UIColor.tableviewBackgroudColor
        setupPlusButtonInNavBar(selector: #selector(handleAdd))
    }
    
    //MARK:- Handle Selector
    @objc private func handleAdd() {
        let createEmployeeVC = CreateEmployeeVC()
        createEmployeeVC.delegate = self
        createEmployeeVC.company = company
        let navController = UINavigationController(rootViewController: createEmployeeVC)
        present(navController, animated: true, completion: nil)
    }
    
    //MARK:- handle functions
    private func fetchEmployees() {
        allEmployees = []
        guard let companyEmployees = company?.employees?.allObjects as? [Employee] else { return }
        
        employeeTypes.forEach { (employeeType) in
            allEmployees.append(
                companyEmployees.filter { $0.type == employeeType }
            )
        }
    }
}



