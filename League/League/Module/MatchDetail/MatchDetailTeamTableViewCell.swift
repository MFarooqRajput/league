//
//  MatchDetailOddsTableViewCell.swift
//  League
//
//  Created by Muhammad Farooq on 2021-02-21.
//

import UIKit

class MatchDetailTeamTableViewCell: UITableViewCell {

    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet var positionImageView: UIImageView!
    @IBOutlet var flagImageView: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var totalMatchLabel: UILabel!
    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var drawLabel: UILabel!
    @IBOutlet weak var lostLabel: UILabel!
    @IBOutlet weak var goalScoredLabel: UILabel!
    @IBOutlet weak var goalAgainstLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func set(with team: SubtournamentTable) {
        
        positionLabel.text = team.teamPosition
        teamNameLabel.text = team.teamName
        totalMatchLabel.text = team.totalFields.teamMatchesTotal
        winLabel.text = team.totalFields.teamWinTotal
        drawLabel.text = team.totalFields.teamDrawTotal
        lostLabel.text = team.totalFields.teamLossTotal
        let arr = team.totalFields.teamGoalsTotal.components(separatedBy: ":")
        goalScoredLabel.text = arr[0]
        goalAgainstLabel.text = arr[1]
        pointsLabel.text = team.teamPoints
        
        if team.teamPositionChange == "up" {
            positionImageView.image = UIImage(systemName: "arrowtriangle.up.fill")
            let newImage = positionImageView.image?.withRenderingMode(.alwaysTemplate)
            positionImageView.image = newImage
            positionImageView.tintColor = .red
        } else if team.teamPositionChange == "same" {
            positionImageView.image = UIImage(systemName: "circle.fill")
            let newImage = positionImageView.image?.withRenderingMode(.alwaysTemplate)
            positionImageView.image = newImage
            positionImageView.tintColor = .darkGray
        } else if team.teamPositionChange == "down" {
            positionImageView.image = UIImage(systemName: "arrowtriangle.down.fill")
            let newImage = positionImageView.image?.withRenderingMode(.alwaysTemplate)
            positionImageView.image = newImage
            positionImageView.tintColor = .green
        } else {
            
        }
        
        guard let flagUrl =  URL(string: "\(Constants.imageBaseUrl)\(team.teamFlagURL)") else {
            return
        }
        
        flagImageView.setImage(with: flagUrl, placeHolder: #imageLiteral(resourceName: "tournament"))
        
        
    }

}
