//
//  Match.swift
//  League
//
//  Created by Muhammad Farooq on 2021-02-18.
//

import Foundation

// MARK: - Data
public struct Data: Codable {
    let data : MatchesData
}

// MARK: - MatchesData
public struct MatchesData: Codable {
    let identifier : String
    let matches : [Match]
    let tournamentTable : String?
    let tournamentName : String
    let tournamentFlagUrl : String
    let tournamentStartDate : String
    let TournamentEndDate : String
    
    enum CodingKeys: String, CodingKey {
        case identifier
        case matches
        case tournamentTable = "tournament_table"
        case tournamentName = "tournament_name"
        case tournamentFlagUrl = "tournament_flag_url"
        case tournamentStartDate = "tournament_start_date"
        case TournamentEndDate = "Tournament_end_date"
    }
    
}

// MARK: - Match
public struct Match: Codable {
    
    let id : Int
    let name : String
    let date : String
    let tournamentId : Int
    let tournamentName : String
    let tournamentFlagUrl : String
    let status : String
    let liveStatus : String
    let htName : String
    let htId: Int
    let htFlagUrl : String
    let atName : String
    let atId: Int
    let atFlagUrl : String
    let score : Score
    let sportId: Int
    let hasHighlights: Bool
    let hasStream: Bool
    let reversible: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case date
        case tournamentId = "tournament_id"
        case tournamentName = "tournament_name"
        case tournamentFlagUrl = "tournament_flag_url"
        case status
        case liveStatus = "live_status"
        case htName = "ht_name"
        case htId = "ht_id"
        case htFlagUrl = "ht_flag_url"
        case atName = "at_name"
        case atId = "at_id"
        case atFlagUrl = "at_flag_url"
        case score
        case sportId = "sport_id"
        case hasHighlights = "has_highlights"
        case hasStream = "has_stream"
        case reversible
    }
}

// MARK: - Score
public struct Score: Codable {
    
    let htScore : String
    let atScore : String
    let scoreDetails : String
    
    enum CodingKeys: String, CodingKey {
        case htScore = "ht_score"
        case atScore = "at_score"
        case scoreDetails = "score_details"
    }
}
