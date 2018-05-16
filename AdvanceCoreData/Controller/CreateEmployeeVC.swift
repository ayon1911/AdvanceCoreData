//
//  CreateEmployeeVC.swift
//  AdvanceCoreData
//
//  Created by Khaled Rahman Ayon on 15.04.18.
//  Copyright © 2018 DocDevs. All rights reserved.
//

import UIKit

protocol CreateEmployeeDelegate {
    func didAddEmployee(employee: Employee)
}

class CreateEmployeeVC: UIViewController {
    
    //MARK:- variables
    var delegate: CreateEmployeeDelegate?
    var company: Company?
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AvenirNext-SemiBold", size: 16)
        label.text = "Name"
        return label
    }()
    
    let birthdayLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AvenirNext-SemiBold", size: 16)
        label.text = "Birthday"
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Name"
        textField.font = UIFont(name: "AvenirNext-Medium", size: 14)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let birthdayTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "MM/dd/yyyy"
        textField.font = UIFont(name: "AvenirNext-SemiBold", size: 14)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let employeeTypeSegmentedControl: UISegmentedControl = {
        let types = [
            EmployeeType.Executive.rawValue,
            EmployeeType.Management.rawValue,
            EmployeeType.Staff.rawValue
        ]
        let sc = UISegmentedControl(items: types)
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "AvenirNext-Medium", size: 11)!], for: .normal)
        sc.selectedSegmentIndex = 0
        sc.tintColor = UIColor.tableviewBackgroudColor
        return sc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Create Employee"
        view.backgroundColor = UIColor.tableviewBackgroudColor
        
        setupCancelButton()
        setupUiWithConstraints()
        
    }
    //MARK:- setupUI
    private func setupUiWithConstraints() {
        _ = lightBlueBackgroundView(height: 150)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
        
        view.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(birthdayLable)
        birthdayLable.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        birthdayLable.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        birthdayLable.widthAnchor.constraint(equalToConstant: 100).isActive = true
        birthdayLable.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(nameTextField)
        nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        nameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
        
        view.addSubview(birthdayTextField)
        birthdayTextField.leftAnchor.constraint(equalTo: birthdayLable.rightAnchor).isActive = true
        birthdayTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        birthdayTextField.bottomAnchor.constraint(equalTo: birthdayLable.bottomAnchor).isActive = true
        birthdayTextField.topAnchor.constraint(equalTo: birthdayLable.topAnchor).isActive = true
        
        view.addSubview(employeeTypeSegmentedControl)
        employeeTypeSegmentedControl.topAnchor.constraint(equalTo: birthdayTextField.bottomAnchor).isActive = true
        employeeTypeSegmentedControl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        employeeTypeSegmentedControl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive  = true
        employeeTypeSegmentedControl.heightAnchor.constraint(equalToConstant: 34).isActive = true
    }
    //MARK:- handle selectors & funtions
    @objc private func handleSave() {
        guard let name = nameTextField.text else { return }
        guard let company = self.company else { return }
        //save birthday
        guard let birthdayText = birthdayTextField.text else { return }
        if birthdayText.isEmpty {
            //show an alert controller!!
            print("Empty birthday")
            showError(titel: "Error Birthday", message: "Please enter a valid birthday")
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        guard let birthdayDate = dateFormatter.date(from: birthdayText) else {
            showError(titel: "Error", message: "invalid date formate, please enter correct date formate")
            return
        }
        guard let employeeType = employeeTypeSegmentedControl.titleForSegment(at: employeeTypeSegmentedControl.selectedSegmentIndex) else { return }
        
        let tuple = CoreDataManager.shared.createEmployee(employeeName: name, birthDay: birthdayDate, employeeType: employeeType, company: company)
        guard let employeeName = tuple.0 else { return }
        if let error = tuple.1 {
            //Show error with an alert controller
            print(error)
        } else {
            dismiss(animated: true) {
                self.delegate?.didAddEmployee(employee: employeeName)
            }
        }
    }
    
    private func showError(titel: String, message: String) {
        let alert = UIAlertController(title: titel, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
