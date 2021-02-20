//
//  Helper.swift
//  League
//
//  Created by Muhammad Farooq on 2021-02-24.
//

import Foundation

class Helper {
    
    class func getFormattedDate(fromDateString: String, fromFormat: String = Constants.DateFormat.serverFormat, toFormat: String = Constants.DateFormat.displayFormat) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = fromFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        guard let date = dateFormatter.date(from: fromDateString) else {
            return " "
        }
        
        dateFormatter.dateFormat = toFormat
        return dateFormatter.string(from: date)
    }
    
    class func today(fromDate: Date = Date(), format: String = Constants.DateFormat.paramFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: fromDate)
    }
}

