//
//  FavoriteCarsProtocol.swift
//  CarGo
//
//  Created by Andrei Mirica on 06.04.2023.
//

import Foundation

protocol FavoriteCarsProtocol {
    static func favoriteCars(userId: String) async throws -> (Data?, NetworkError?)
}
