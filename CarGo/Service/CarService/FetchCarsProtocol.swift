//
//  FetcCarsProtocol.swift
//  CarGo
//
//  Created by Andrei Mirica on 01.03.2023.
//

import Foundation

protocol FetchCarsProtocol {
    static func fetchCars() async throws -> (Data?, NetworkError?)
}
