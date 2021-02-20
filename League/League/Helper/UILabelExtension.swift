//
//  UILabelExtension.swift
//  League
//
//  Created by Muhammad Farooq on 2021-02-23.
//

import UIKit

extension UILabel {

    func setRoundedLabel(type: LabelType) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.height/2
        
        switch type {
        case .win:
            self.text = "W"
            self.backgroundColor = Constants.Color.winColor
        case .draw:
            self.text = "D"
            self.backgroundColor = Constants.Color.drawColor
        case .lost:
            self.text = "L"
            self.backgroundColor = Constants.Color.lossColor
        case .point:
            self.backgroundColor =  Constants.Color.pointColor
        case .empty:
            self.backgroundColor = UIColor.darkGray
        }
    }

}
