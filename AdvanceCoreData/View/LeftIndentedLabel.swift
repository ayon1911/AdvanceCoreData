//
//  LeftIndentedLabel.swift
//  AdvanceCoreData
//
//  Created by Khaled Rahman Ayon on 18.04.18.
//  Copyright © 2018 DocDevs. All rights reserved.
//

import UIKit

class LeftIndentedLabel: UILabel {

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        let customRect = UIEdgeInsetsInsetRect(rect, insets)
        super.drawText(in: customRect)
    }
}
