//
//  ApiService.swift
//  AdvanceCoreData
//
//  Created by Khaled Rahman Ayon on 13.05.18.
//  Copyright © 2018 DocDevs. All rights reserved.
//

import Foundation

struct ApiService {
    
    static let shared = ApiService()
    let urlString = "http://api.letsbuildthatapp.com/intermediate_training/companies"
    
    func downloadCompaniesFromServer() {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("Error downloading json")
            } else {
                guard let data = data else { return }
                
                let jsonDecoder = JSONDecoder()
                do {
                    let jsonCompany = try jsonDecoder.decode([JSONCompany].self, from: data)
                    jsonCompany.forEach({ (company) in
                        print(company.name)
                        company.employees?.forEach({ (employee) in
                            print("---\(employee.name)")
                        })
                    })
                } catch let err {
                    print(err.localizedDescription)
                }
            }
        }.resume()
    }
}

struct JSONCompany: Decodable {
    let name: String
    let founded: String
    var employees: [JSONEmployee]?
}

struct JSONEmployee: Decodable {
    let name: String
    let type: String
    let birthday: String
}
