//
//  BookedCarDTO.swift
//  CarGo
//
//  Created by Andrei Mirica on 12.04.2023.
//

import Foundation

struct BookingInfo: Decodable {
    let toDate: String
    let status: String
    let renterDetails: UserDetailsData
    let id: String
    let carInfo: CarInfoDTO
    let fromDate: String
    let hostInfo: HostInfoDTO
}
