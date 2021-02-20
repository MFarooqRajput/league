//
//  Constants.swift
//  League
//
//  Created by Muhammad Farooq on 2021-02-18.
//

import Foundation
import UIKit

class Constants {
    
    static let apiBaseUrl = "https://psydreus.oddsium.com/"
    static let imageBaseUrl = "http://zeus.oddsium.com/i/"
    
    struct Segues {
        static let matchDetailSegue = "MatchDetailSegue"
    }
    
    struct Sport {
            static let football = "1"
    }
    
    struct Timeszone {
            static let stockholm = "europe/stockholm"
    }
    
    struct CountryCode {
        static let sweden = "SE"
    }
    
    struct DateFormat {
        static let serverFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        static let displayFormat = "EEEE, MMM d, HH:mm"
        static let paramFormat = "yyyy-MM-dd"
    }
    
    struct Color {
        static let winColor = UIColor(red: 0.0/255, green: 197.0/255, blue: 25.0/255, alpha: 1.0)
        static let drawColor = UIColor(red: 255.0/255, green: 190.0/255, blue: 30.0/255, alpha: 1.0)
        static let lossColor = UIColor(red: 255.0/255, green: 0.0/255, blue: 15.0/255, alpha: 1.0)
        static let pointColor = UIColor(red: 237.0/255, green: 237.0/255, blue: 237.0/255, alpha: 1.0)
        static let progressFillColor = UIColor(red: 0.0/255, green: 110.0/255, blue: 250.0/255, alpha: 1.0)
        static let progressColor = UIColor(red: 115.0/255, green: 115.0/255, blue: 115.0/255, alpha: 1.0)
        static let cellEvenColor = UIColor(red: 237.0/255, green: 237.0/255, blue: 237.0/255, alpha: 1.0)
        static let cellOddColor = UIColor(red: 211.0/255, green: 211.0/255, blue: 211.0/255, alpha: 1.0)
    }
    
}

enum SuffixURL: String {
    case matches = "matches"
    case match = "match"
}

enum ResponseError: Error {
    case requestFailed
    case responseUnsuccessful(statusCode: Int)
    case invalidData
    case jsonParsingFailure
    case invalidURL
}

enum LabelType: String {
    case win, draw, lost, point, empty
}
