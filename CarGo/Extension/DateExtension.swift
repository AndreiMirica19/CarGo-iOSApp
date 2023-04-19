//
//  DateExtension.swift
//  CarGo
//
//  Created by Andrei Mirica on 30.03.2023.
//

import Foundation

extension Date {
    
    func changeToLocalTimezone() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM HH:mm"
        dateFormatter.timeZone = TimeZone.current

        let formattedDate = dateFormatter.string(from: self)

        return formattedDate
    }
    
    func isBetween(_ date1: Date, and date2: Date) -> Bool {
         return (min(date1, date2) ... max(date1, date2)).contains(self)
     }
    
    func isAfter(_ date: Date) -> Bool {
         self > date
    }
}
