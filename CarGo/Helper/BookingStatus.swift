//
//  BookingStatus.swift
//  CarGo
//
//  Created by Andrei Mirica on 18.04.2023.
//

import Foundation

enum BookingStatus: String {
    case cancelled = "Cancelled"
    case hostCancelled = "Cancelled by the host"
    case pending = "Pending"
    case accepted = "Accepted by host"
    case inProgress = "In progress"
    case completed = "Completed"
}
