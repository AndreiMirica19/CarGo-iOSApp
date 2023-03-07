//
//  CarData.swift
//  CarGo
//
//  Created by Andrei Mirica on 06.03.2023.
//

import Foundation

class CarData: Codable, ObservableObject {
     var ownerId = ""
     var numberPlate = ""
     var manufacturer = ""
     var model = ""
     var manufactureYear = ""
     var transmission = ""
     var color = ""
     var fuel = ""
     var numberSeats = ""
     var street = ""
     var city = ""
     var country = ""
     var photos: [Data] = []
     var price = ""
     var currency = ""
     var discount = false
}
