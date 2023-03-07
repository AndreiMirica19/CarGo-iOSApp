//
//  OwnedCarsProtocol.swift
//  CarGo
//
//  Created by Andrei Mirica on 07.03.2023.
//

import Foundation

protocol OwnedCarsProtocol {
    static func ownedCars(ownerId: String) async throws -> (Data?, NetworkError?)
}
