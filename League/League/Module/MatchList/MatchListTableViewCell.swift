//
//  MatchListTableViewCell.swift
//  League
//
//  Created by Muhammad Farooq on 2021-02-18.
//

import UIKit

class MatchListTableViewCell: UITableViewCell {

    @IBOutlet var homeTeamFlagImageView: UIImageView!
    @IBOutlet var awayTeamFlagImageView: UIImageView!
    
    @IBOutlet weak var homeTeamNameLabel: UILabel!
    @IBOutlet weak var awayTeamNameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var liveStatusDetailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func set(with match: Match) {
        
        awayTeamNameLabel.text = match.atName
        homeTeamNameLabel.text = match.htName
        scoreLabel.text = match.score.htScore + " - " + match.score.atScore
        
        if match.status == "Live" {
            statusLabel.isHidden = false
            liveStatusDetailLabel.isHidden = false
            statusLabel.text = "LIVE!"
            let arr = match.liveStatus.components(separatedBy: "'")
            
            if let t = Int(arr[0]) {
                
                if t > 45 {
                    liveStatusDetailLabel.text = "2nd Half' " + arr[1]
                } else {
                    liveStatusDetailLabel.text = "1st Half' " + arr[1]
                }
            }
        } else {
            statusLabel.isHidden = true
            liveStatusDetailLabel.isHidden = true
        }
        
        guard let htFlagUrl =  URL(string: "\(Constants.imageBaseUrl)\(match.htFlagUrl)"), let atFlagUrl =  URL(string: "\(Constants.imageBaseUrl)\(match.atFlagUrl)") else {
            return
        }
        
        homeTeamFlagImageView.setImage(with: htFlagUrl, placeHolder: #imageLiteral(resourceName: "flag"))
        awayTeamFlagImageView.setImage(with: atFlagUrl, placeHolder: #imageLiteral(resourceName: "flag"))
        
    }
}
