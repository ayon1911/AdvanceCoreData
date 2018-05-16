//
//  UiViewController+Helpers.swift
//  AdvanceCoreData
//
//  Created by Khaled Rahman Ayon on 15.04.18.
//  Copyright © 2018 DocDevs. All rights reserved.
//

import UIKit

extension UIViewController {
    //helperMethods
    func setupPlusButtonInNavBar(selector: Selector) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: .plain, target: self, action: selector)
    }
    
    func setupCancelButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancelModal))
    }
    
    @objc func handleCancelModal() {
        dismiss(animated: true, completion: nil)
    }
    
    func lightBlueBackgroundView(height: CGFloat) -> UIView {
        let lightBackgroundView = UIView()
        lightBackgroundView.backgroundColor = UIColor.headerViewColor
        lightBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lightBackgroundView)
        lightBackgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        lightBackgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        lightBackgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        lightBackgroundView.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        return lightBackgroundView
    }
}
