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
}
