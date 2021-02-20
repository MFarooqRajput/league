//
//  MatchListTableViewHeader.swift
//  League
//
//  Created by Muhammad Farooq on 2021-02-18.
//

import UIKit

class MatchListTableViewHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet var flagImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func set(with date: String, flagUrl: String, name: String) {
        dateLabel.text = date
        nameLabel.text = name
        
        guard let url =  URL(string: "\(Constants.imageBaseUrl)\(flagUrl)") else {
            return
        }
        
        flagImageView.setImage(with: url, placeHolder: #imageLiteral(resourceName: "tournament"))
    }

}
