//
//  EmployeesVC.swift
//  AdvanceCoreData
//
//  Created by Khaled Rahman Ayon on 15.04.18.
//  Copyright © 2018 DocDevs. All rights reserved.
//

import UIKit

class EmployeesVC: UITableViewController {
    
    var company: Company?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let navController = UINavigationController(rootViewController: createEmployeeVC)
        present(navController, animated: true, completion: nil)
    }
}
