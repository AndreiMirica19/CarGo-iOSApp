//
//  ToggleFavoriteCar.swift
//  CarGo
//
//  Created by Andrei Mirica on 06.04.2023.
//

import Foundation

protocol ToggleFavoriteCarProtocol {
    static func toggleFavoriteCar(userId: String, carId: String) async throws -> (Data?, NetworkError?)
}
