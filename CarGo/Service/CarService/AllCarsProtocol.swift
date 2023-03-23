//
//  AllCarsProtocol.swift
//  CarGo
//
//  Created by Andrei Mirica on 20.03.2023.
//

import Foundation

protocol AllCarsProtocol {
    static func allCars() async throws -> (Data?, NetworkError?)
}
