//
//  EmployeesVC+UiTableView.swift
//  AdvanceCoreData
//
//  Created by Khaled Rahman Ayon on 17.04.18.
//  Copyright © 2018 DocDevs. All rights reserved.
//

import UIKit

extension EmployeesVC: CreateEmployeeDelegate {
    
    func didAddEmployee(employee: Employee) {
        guard let section = employeeTypes.index(of: employee.type!) else { return }
        let row = allEmployees[section].count
        let indexPath = IndexPath(row: row, section: section)
        allEmployees[section].append(employee)
        tableView.insertRows(at: [indexPath], with: .middle)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return allEmployees.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = LeftIndentedLabel()
        label.text = employeeTypes[section]
        label.backgroundColor = UIColor.headerViewColor
        label.textColor = .black
        label.font = UIFont(name: "AvenirNext-Bold", size: 15.0)
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allEmployees[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EMPLOYEE_CELL_ID, for: indexPath)
        let employee = allEmployees[indexPath.section][indexPath.row]
        cell.textLabel?.text = employee.name
        
        if let birthdayDate = employee.employeeInfo?.dateOfBirth {
             let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy"
            cell.textLabel?.text = "\(employee.name ?? "") \(dateFormatter.string(from: birthdayDate))"
        }
        cell.backgroundColor = UIColor.cellBackgroundColor
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont(name: "AvenirNext-Medium", size: 18.0)
        return cell
    }
}
