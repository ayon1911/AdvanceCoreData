//
//  ViewController.swift
//  AdvanceCoreData
//  Created by Khaled Rahman Ayon on 02.04.18.
//  Copyright © 2018 DocDevs. All rights reserved.
//

import UIKit
import CoreData

class CompaniesVC: UITableViewController {
    
    //MARK:- variables
    var companies = [Company]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        additionalNavBarSetup()
        setupTableView()
        view.backgroundColor = .tableviewBackgroudColor
        
        self.companies = CoreDataManager.shared.fetchCompanies()
    }
    
    //MARK:- setup
    fileprivate func additionalNavBarSetup () {
        navigationItem.title = "Companies"
        setupPlusButtonInNavBar(selector: #selector(handleAddCompany))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(handleResetCompany))
    }
    
    func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.register(CompanyCell.self, forCellReuseIdentifier: COMPANY_CELL_ID)
    }
    
    //MARK:- handel functionalities
    @objc private func handleAddCompany() {
        let createCompanyVC = CreateCompanyVC()
        let navController = CustomNavController(rootViewController: createCompanyVC)
        createCompanyVC.delegate = self
        present(navController, animated: true, completion: nil)
    }
    
    @objc private func handleResetCompany() {
        CoreDataManager.shared.batchDelete {
            var indexPathsToRemove = [IndexPath]()
            for (index, _) in companies.enumerated() {
                let indexPath = IndexPath(row: index, section: 0)
                indexPathsToRemove.append(indexPath)
            }
            companies.removeAll()
            tableView.deleteRows(at: indexPathsToRemove, with: .left)
        }
    }
}
