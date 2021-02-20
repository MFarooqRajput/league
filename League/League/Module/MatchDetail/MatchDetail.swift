//
//  MatchDetail.swift
//  League
//
//  Created by Muhammad Farooq on 2021-02-21.
//

import Foundation

// MARK: - MatchResponse
struct MatchResponse: Codable {
    let identifier: String
    let data: MatchDetail
}

// MARK: - MatchDetail
struct MatchDetail: Codable {
    let id: Int
    let name, date: String
    let sportID, tournamentID: Int
    let tournamentName, tournamentFlagURL, status, liveStatus, progressBar, htName: String
    let htID: Int
    let htFlagURL, atName: String
    let atID: Int
    let atFlagURL : String
    
    let h2hHomePosition, h2hHomePositionChange, h2hAwayPosition, h2hAwayPositionChange: String
    
    let h2hHomeWins, h2hAwayWins, h2hDraws, h2hHomeWinsRate, h2hAwayWinsRate, h2hDrawsRate: String
    
    let tournamentStartDate, tournamentEndDate: String
    
    let score: Score
    let matchEvents: [MatchEvent]
    let matchStatistics: [MatchStatistic]
    
    let oddsFormatName: String
    let oddsFormatID: Int
    let submarketName: String
    let submarketID: Int
    let oddsName : [OddsName]?
    let operatorOdds : [OperatorOdds]?
    let availableSubmarkets : [AvailableSubmarkets]?
    let tournamentTable: [TournamentTable]
    let teamsForm: TeamsForm
    let matchHighlights: [MatchHighlight]?
    let reversible: Bool

    enum CodingKeys: String, CodingKey {
        case id, name, date
        case sportID = "sport_id"
        case tournamentID = "tournament_id"
        case tournamentName = "tournament_name"
        case tournamentFlagURL = "tournament_flag_url"
        case status
        case liveStatus = "live_status"
        case progressBar = "progress_bar"
        case htName = "ht_name"
        case htID = "ht_id"
        case htFlagURL = "ht_flag_url"
        case atName = "at_name"
        case atID = "at_id"
        case atFlagURL = "at_flag_url"
        
        case h2hHomePosition = "h2h_home_position"
        case h2hHomePositionChange = "h2h_home_position_change"
        case h2hAwayPosition = "h2h_away_position"
        case h2hAwayPositionChange = "h2h_away_position_change"
        
        case h2hHomeWins = "h2h_home_wins"
        case h2hAwayWins = "h2h_away_wins"
        case h2hDraws = "h2h_draws"
        
        case h2hHomeWinsRate = "h2h_home_wins_rate"
        case h2hAwayWinsRate = "h2h_away_wins_rate"
        case h2hDrawsRate = "h2h_draws_rate"
        
        case tournamentStartDate = "tournament_start_date"
        case tournamentEndDate = "Tournament_end_date"
        
        case score
        case matchEvents = "match_events"
        case matchStatistics = "match_statistics"
        
        case oddsFormatName = "odds_format_name"
        case oddsFormatID = "odds_format_id"
        case submarketName = "submarket_name"
        case submarketID = "submarket_id"
        case oddsName = "odds_name"
        case operatorOdds = "operator_odds"
        case availableSubmarkets = "available_submarkets"
        case tournamentTable = "tournament_table"
        case teamsForm = "teams_form"
        case matchHighlights = "match_highlights"
        case reversible
    }
}

// MARK: - MatchEvent
struct MatchEvent: Codable {
    let eventName, eventTeam, eventTime, eventPlayer, eventFlagURL: String
    
    enum CodingKeys: String, CodingKey {
        case eventName = "event_name"
        case eventTeam = "event_team"
        case eventTime = "event_time"
        case eventPlayer = "event_player"
        case eventFlagURL = "event_flag_url"
    }
}

// MARK: - MatchStatistic
struct MatchStatistic: Codable {
    let htStatistic, atStatistic, statisticID: String
    let reversible: Bool

    enum CodingKeys: String, CodingKey {
        case htStatistic = "ht_statistic"
        case atStatistic = "at_statistic"
        case statisticID = "statistic_id"
        case reversible
    }
}

// MARK: - TeamsForm
struct TeamsForm: Codable {
    let homeTeam, awayTeam: Team

    enum CodingKeys: String, CodingKey {
        case homeTeam = "home_team"
        case awayTeam = "away_team"
    }
}

// MARK: - Team
struct Team: Codable {
    let form: [Form]
}

// MARK: - Form
struct Form: Codable {
    let row: String
}

// MARK: - TournamentTable
struct TournamentTable: Codable {
    let subtournamentTable: [SubtournamentTable]

    enum CodingKeys: String, CodingKey {
        case subtournamentTable = "subtournament_table"
    }
}

// MARK: - SubtournamentTable
struct SubtournamentTable: Codable {
    let teamID: Int
    let teamName, teamFlagURL, teamPosition, teamPositionChange, teamPoints: String
    let subtournamentID: Int
    let subtournamentName: String
    let totalFields: TotalFields

    enum CodingKeys: String, CodingKey {
        case teamID = "team_id"
        case teamName = "team_name"
        case teamFlagURL = "team_flag_url"
        case teamPosition = "team_position"
        case teamPositionChange = "team_position_change"
        case teamPoints = "team_points"
        case subtournamentID = "subtournament_id"
        case subtournamentName = "subtournament_name"
        case totalFields = "total_fields"
    }
}

// MARK: - TotalFields
struct TotalFields: Codable {
    let teamMatchesTotal, teamWinTotal, teamDrawTotal, teamLossTotal, teamGoalsTotal, teamGoalDiffTotal: String

    enum CodingKeys: String, CodingKey {
        case teamMatchesTotal = "team_matches_total"
        case teamWinTotal = "team_win_total"
        case teamDrawTotal = "team_draw_total"
        case teamLossTotal = "team_loss_total"
        case teamGoalsTotal = "team_goals_total"
        case teamGoalDiffTotal = "team_goal_diff_total"
    }
}

struct MatchHighlight: Codable {
    let highlightUrl : String
    let highlightType, operatorId : Int

    enum CodingKeys: String, CodingKey {
        case highlightUrl = "highlight_url"
        case highlightType = "highlight_type"
        case operatorId = "operator_id"
    }
}

struct AvailableSubmarkets: Codable {
    let submarketId, operatorCount : Int

    enum CodingKeys: String, CodingKey {
        case submarketId = "submarket_id"
        case operatorCount = "operator_count"
    }
}

struct OperatorOdds: Codable {
    let operatorName : String
    let operatorId : Int
    let operatorFlagUrl : String
    let isOpen : Bool
    let operatorMatchId, operatorTournamentId : String
    let odds : [Odds]
    enum CodingKeys: String, CodingKey {
        case operatorName = "operator_name"
        case operatorId = "operator_id"
        case operatorFlagUrl = "operator_flag_url"
        case isOpen = "is_open"
        case operatorMatchId = "operator_match_id"
        case operatorTournamentId = "operator_tournament_id"
        case odds
    }
}

struct Odds: Codable {
   
    let oddsValue, oddsId, oddsValueReq : String
    
    enum CodingKeys: String, CodingKey {
        case oddsValue = "odds_value"
        case oddsId = "odds_id"
        case oddsValueReq = "odds_value_req"
    }
}

struct OddsName: Codable {
    let name : String
}
