//
//  MatchDetailPresenter.swift
//  League
//
//  Created by Muhammad Farooq on 2021-02-21.
//

import Foundation

// MARK: - PropertyListView

public protocol MatchDetailView: class {
    func updateMatchDetailView(isOddsAvail: Bool)
    func showErrorView(_ error: String)
    func hideErrorView()
    func activityIndicatorAnimatingView(animating: Bool)
}

class MatchDetailPresenter {
    
    private weak var view: MatchDetailView?
    private let matchDetailRepo = MatchDetailRepo()
    
    var match: MatchDetail! {
        didSet {
            
            if match.oddsName != nil {
                self.view?.updateMatchDetailView(isOddsAvail :true)
            } else {
                self.view?.updateMatchDetailView(isOddsAvail: false)
            }
        }
    }
    
    public init(view: MatchDetailView?) {
        self.view = view
    }
    
    func fetchMatchDetail(matchId: Int) {
        
        let params: [String: String] = ["submarket":"1",
                                        "match":String(matchId),
                                        "countrycode":Constants.CountryCode.sweden,
                                        "oddstype":"1"]
        
        self.view?.activityIndicatorAnimatingView(animating: true)
        self.view?.hideErrorView()
        
        matchDetailRepo.fetchMatchDetail(with: .match, params: params) { [weak self] matchDetailData, error in
            
            if let matchDetailData = matchDetailData {
                self?.match = matchDetailData.data
                self?.view?.activityIndicatorAnimatingView(animating: false)
            } else {
                self?.view?.activityIndicatorAnimatingView(animating: false)
                self?.view?.showErrorView(error?.localizedDescription ?? "Property data is not available")
            }
        }
        
    }
    
    func getOdds() -> (firstOdd: String?, secondOdd: String?, thirdOdd: String?) {
        
        var firstOdd : String?
        var secondOdd : String?
        var thirdOdd : String?
        
        if let odds = match.oddsName {
            firstOdd = odds[0].name
            secondOdd = odds[1].name
            thirdOdd = odds[2].name
        }
        
        return (firstOdd, secondOdd, thirdOdd)
    }
    
    func getHeader() -> (name: String, flag: String){
        return (match.tournamentName, match.tournamentFlagURL)
    }
    
    func getMatchDetail() -> (date: String?, status: String, liveStatusDetail: String?, homeTeamName: String, homeTeamFlag: String, awayTeamName: String, awayTeamFlag: String, score: String) {
        
        let dateString = Helper.getFormattedDate(fromDateString: match.date)
        
        var liveStatusDetail : String?
        
        let status = match.status
        
        if status == "Live" {
            
            let arr = match.liveStatus.components(separatedBy: "'")
            
            if let t = Int(arr[0]) {
                
                if t > 45 {
                    liveStatusDetail = "2nd Half' " + arr[1]
                } else {
                    liveStatusDetail = "1st Half' " + arr[1]
                }
            }
        }
        
        let score = match.score.htScore + " - " + match.score.atScore
        
        return (dateString, status, liveStatusDetail, match.htName, match.htFlagURL, match.atName, match.atFlagURL, score)
    }
    
    func getTeamsForm() -> TeamsForm {
        match.teamsForm
    }
    
    func getProgress() -> Float {
        
        if match.progressBar == "" {
            
            return 0.0
        } else {
            
            let progress = (match.progressBar as NSString).floatValue
            return progress / 100.0
        }
    }
    
    func getTeamsCount() -> Int {
        
        if match != nil {
            if match.tournamentTable.count > 0 {
                return match.tournamentTable[0].subtournamentTable.count
            }
            
        }
        
        return 0
    }
    
    func getOddsCount() -> Int {
        
        if match != nil {
            
            if let odds = match.operatorOdds {
                return odds.count
            }
        }
        
        return 0
    }
    
    func teamAt(index: Int) -> SubtournamentTable? {
        
        if match != nil {
            return match.tournamentTable[0].subtournamentTable[index]
        }
        return nil
    }
    
    func oddsAt(index: Int) -> (OperatorOdds)? {
        
        if let odds = match.operatorOdds {
            return  odds[index]
        }
        
        return nil
    }
    
}
