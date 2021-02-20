//
//  MatchDetailTeamTableViewCell.swift
//  League
//
//  Created by Muhammad Farooq on 2021-02-21.
//

import UIKit

class MatchDetailOddsTableViewCell: UITableViewCell {

    @IBOutlet var flagImageView: UIImageView!
    @IBOutlet weak var oddsOneLabel: UILabel!
    @IBOutlet weak var oddsTwoLabel: UILabel!
    @IBOutlet weak var oddsThreeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        oddsOneLabel.setRoundedLabel(type: .point)
        oddsTwoLabel.setRoundedLabel(type: .point)
        oddsThreeLabel.setRoundedLabel(type: .point)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func set(with operatorOdds: OperatorOdds) {
        
        if operatorOdds.odds[0].oddsValue == "" {
            oddsOneLabel.text = "N/A"
        } else {
            oddsOneLabel.text = operatorOdds.odds[0].oddsValue
        }
        
        if operatorOdds.odds[1].oddsValue == "" {
            oddsTwoLabel.text = "N/A"
        } else {
            oddsTwoLabel.text = operatorOdds.odds[1].oddsValue
        }
        
        if operatorOdds.odds[2].oddsValue == "" {
            oddsThreeLabel.text = "N/A"
        } else {
            oddsThreeLabel.text = operatorOdds.odds[2].oddsValue
        }
        
        guard let flagUrl =  URL(string: "\(Constants.imageBaseUrl)\(operatorOdds.operatorFlagUrl)") else {
            return
        }
        
        flagImageView.setImage(with: flagUrl, placeHolder: #imageLiteral(resourceName: "tournament"))
        
    }
}
