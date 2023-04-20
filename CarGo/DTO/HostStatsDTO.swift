//
//  HostStatsDTO.swift
//  CarGo
//
//  Created by Andrei Mirica on 20.04.2023.
//

import Foundation

struct HostStatsDTO: Codable {
    let totalEarnings: Int
    let completedBookings: Int
    let numberOfReviews: Int
    let numberOfStars: Int
    let mostBookedCar: CarInfoDTO?
}
