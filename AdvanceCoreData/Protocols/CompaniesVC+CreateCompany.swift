//
//  CompaniesVC+CreateCompany.swift
//  AdvanceCoreData
//
//  Created by Khaled Rahman Ayon on 15.04.18.
//  Copyright © 2018 DocDevs. All rights reserved.
//

import UIKit

extension CompaniesVC: CreateCompanyDelegate {
    
    func didAddCompany(company: Company) {
        companies.append(company)
        let index = IndexPath(row: companies.count - 1, section: 0)
        tableView.insertRows(at: [index], with: .automatic)
    }
    
    func didEditCompany(company: Company) {
        let row = companies.index(of: company)
        let reloadIndexPath = IndexPath(row: row!, section: 0)
        tableView.reloadRows(at: [reloadIndexPath], with: UITableViewRowAnimation.middle)
    }
}
