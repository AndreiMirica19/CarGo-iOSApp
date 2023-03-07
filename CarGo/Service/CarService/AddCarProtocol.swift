//
//  AddCarProtocol.swift
//  CarGo
//
//  Created by Andrei Mirica on 06.03.2023.
//

import Foundation

protocol AddCarProtocol {
    static func addCar(carData: CarData) async throws -> (Data?, NetworkError?)
}
