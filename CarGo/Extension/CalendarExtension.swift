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
    }
