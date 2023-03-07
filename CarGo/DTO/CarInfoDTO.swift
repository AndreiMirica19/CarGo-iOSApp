//
//  OwnedCarDTO.swift
//  CarGo
//
//  Created by Andrei Mirica on 07.03.2023.
//

import Foundation

struct CarInfoDTO: Codable {
    var id: String
    var ownerId: String
    var numberPlate: String
    var manufacturer: String
    var model: String
    var manufactureYear: String
    var transmission: String
    var color: String
    var fuel: String
    var numberSeats: String
    var street: String
    var city: String
    var country: String
    var photos: [Data]
    var price: String
    var currency: String
    var discount: Bool
}
