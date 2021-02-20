//
//  MatchListPresenter.swift
//  League
//
//  Created by Muhammad Farooq on 2021-02-18.
//

import Foundation

// MARK: - PropertyListView

public protocol MatchListView: class {
    func reloadView()
    func showErrorView(_ error: String)
    func hideErrorView()
    func activityIndicatorAnimatingView(animating: Bool)
}

class MatchListPresenter {
    
    private weak var view: MatchListView?
    private let matchListRepo = MatchListRepo()
    var matches: [[Match]] = []
    var matchId: Int!
    
    public init(view: MatchListView?) {
        self.view = view
    }
    
    func fetchMatches() {
        
        let params: [String: String] = ["date":Helper.today(),
                                        "sport":Constants.Sport.football,
                                        "timezone":Constants.Timeszone.stockholm]
        
        self.view?.activityIndicatorAnimatingView(animating: true)
        self.view?.hideErrorView()
        
        matchListRepo.fetchMatchList(with: .matches, params: params) { [weak self] matchList, error in
            if let matchList = matchList {
                
                let dateDictionary = Dictionary(grouping: matchList.data.matches, by: { (element: Match) in
                    return element.date
                })
                
                let sortedDateArray = dateDictionary.sorted( by: { $0.0 < $1.0 })
                for dateMatches in sortedDateArray {
                    let leagueDictionary = Dictionary(grouping: dateMatches.value, by: { (element: Match) in
                        return element.tournamentFlagUrl
                    })
                    
                    let sortedLeagueArray = leagueDictionary.sorted( by: { $0.0 < $1.0 })
                    
                    for leagueMatches in sortedLeagueArray {
                        self?.matches.append(leagueMatches.value)
                    }
                    
                }
                
                self?.view?.activityIndicatorAnimatingView(animating: false)
                self?.view?.reloadView()
            } else {
                self?.view?.activityIndicatorAnimatingView(animating: false)
                self?.view?.showErrorView(error?.localizedDescription ?? "Match data is not available")
            }
        }
    }
    
    func getSlotsCount() -> Int {
        return matches.count
    }
    
    func getMatchesCount(timeSlot: Int) -> Int {
        return matches[timeSlot].count
    }
    
    func getHeaderFor(timeSlot: Int) -> (date:String, flagUrl:String, name:String)? {
        let temp = matches[timeSlot][0]
        let dateString = Helper.getFormattedDate(fromDateString: temp.date)
        
        return (dateString,temp.tournamentFlagUrl,temp.tournamentName)
    }
    
    func getMatchAt(timeSlot: Int, row: Int) -> Match? {
        return matches[timeSlot][row]
    }
    
    func selectMacthAtIndex(section: Int, row: Int) {
        let match = matches[section][row]
        matchId = match.id
    }
}
