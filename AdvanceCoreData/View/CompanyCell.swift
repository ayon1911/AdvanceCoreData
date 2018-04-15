//
//  CompanyCell.swift
//  AdvanceCoreData
//
//  Created by Khaled Rahman Ayon on 15.04.18.
//  Copyright © 2018 DocDevs. All rights reserved.
//

import UIKit

class CompanyCell: UITableViewCell {
    
    //MARK:- variables
    var company: Company? {
        didSet {
            setupCellProperties(company: company)
        }
    }
    
    let companyImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "photo"))
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 22
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.darkGray.cgColor
        imageView.layer.borderWidth = 1
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameFoundedLbl: UILabel = {
        let label = UILabel()
        label.text = "Company Name"
        label.font = UIFont(name: "AvenirNext-Medium", size: 15.0)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCellUi()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK:- SetupUi
    private func setupCellProperties(company: Company?) {
        if let name = company?.name, let founded = company?.founded {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy"
            let formatedDate = dateFormatter.string(from: founded)
            nameFoundedLbl.text = "\(name) - Founded \(formatedDate)"
            if let imageData = company?.imageData {
                companyImageView.image = UIImage(data: imageData)
            }
        } else {
            nameFoundedLbl.text = company?.name
        }
    }
    
    private func setupCellUi() {
        backgroundColor = UIColor.cellBackgroundColor
        addSubview(companyImageView)
        companyImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        companyImageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        companyImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        companyImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(nameFoundedLbl)
        nameFoundedLbl.leftAnchor.constraint(equalTo: companyImageView.rightAnchor, constant: 8).isActive = true
        nameFoundedLbl.topAnchor.constraint(equalTo: topAnchor).isActive = true
        nameFoundedLbl.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        nameFoundedLbl.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
}
