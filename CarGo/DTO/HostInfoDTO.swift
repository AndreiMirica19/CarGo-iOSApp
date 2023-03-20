//
//  HostInfoDTO.swift
//  CarGo
//
//  Created by Andrei Mirica on 20.03.2023.
//

import Foundation

struct HostInfoDTO: Codable {
    let hostDetails: UserDetailsData
    let ownedCars: [CarInfoDTO]
    let reviews: [Review]
}

struct Review: Codable {
    var userProfilePicture: Date
    var userName: String
    var stars: Int
    var date: Date
}
