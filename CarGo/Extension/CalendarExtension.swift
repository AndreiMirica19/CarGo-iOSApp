//
//  CalendarExtension.swift
//  CarGo
//
//  Created by Andrei Mirica on 02.03.2023.
//

import Foundation

extension Calendar {
    
    static func getYears() -> [String] {
        let currentYear = Calendar.current.component(.year, from: Date())
        return (1950...currentYear).map { String($0) }.reversed()
    }
    
    static func changeDateTime(hour: Double, date: Date) -> Date? {
        
        var calendar = self.current
        calendar.timeZone = TimeZone.current
        let minutes = Int((hour.truncatingRemainder(dividingBy: 1)) * 60)
        let newDate = calendar.date(bySettingHour: Int(hour), minute: minutes, second: 0, of: date)
        return newDate
    }
}
