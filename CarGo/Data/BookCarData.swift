//
//  BookCarData.swift
//  CarGo
//
//  Created by Andrei Mirica on 11.04.2023.
//

import Foundation

struct BookCarData: Codable {
    var ownerId: String
    var renterId: String
    var carId: String
    var fromDate: String
    var toDate: String
    var status: String
}
