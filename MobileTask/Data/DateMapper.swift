//
//  DateMapper.swift
//  MobileTask
//
//  Created by Anton on 26/02/24.
//

import Foundation

class DateMapper {
    private lazy var dateFormatter = DateFormatter()
    private let dateFormat = "MMMM dd, yyyy"
    private let initialDateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    private let timeFormat = "h:mm a"
    
    func formatDate(stringDate: String?, timezone: String?) -> (date: String, time: String) {
        guard let initialDateUTC = stringDate else {
            return ("", "")
        }
        
        dateFormatter.dateFormat = initialDateFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        guard let initialDate = dateFormatter.date(from: initialDateUTC) else {
            return ("", "")
        }
        
        if let timezoneID = timezone, let timezone = TimeZone(identifier: timezoneID)  {
            dateFormatter.timeZone = timezone
        } else {
            dateFormatter.timeZone = TimeZone(abbreviation: "EST")
        }
        
        dateFormatter.dateFormat = dateFormat
        let dateString = dateFormatter.string(from: initialDate)
        
        dateFormatter.dateFormat = timeFormat
        let timeString = dateFormatter.string(from: initialDate)
        return (dateString, timeString)
    }
}
