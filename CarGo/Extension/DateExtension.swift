//
//  DateExtension.swift
//  CarGo
//
//  Created by Andrei Mirica on 30.03.2023.
//

import Foundation

extension Date {
    
    static func changeToLocalTimezone(initialDate: Date) -> Date {
        
        let timezoneOffset = TimeZone.current.secondsFromGMT()
        let epochDate = initialDate.timeIntervalSince1970
        
        let timezoneDateEpochOffset = (epochDate + Double(timezoneOffset))
        
        return Date(timeIntervalSince1970: timezoneDateEpochOffset)
    }
}

