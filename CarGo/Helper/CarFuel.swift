//
//  CarFuel.swift
//  CarGo
//
//  Created by Andrei Mirica on 02.03.2023.
//

import Foundation

enum CarFuel: String, CaseIterable {
    case none = "-"
    case gasoline = "Gasoline"
    case diesel = "Diesel"
    case hybrid = "Hybrid/Electric"
    case lpg = "Lpg"
}
