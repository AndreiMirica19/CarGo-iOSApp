//
//  UserBookingsProtocol.swift
//  CarGo
//
//  Created by Andrei Mirica on 12.04.2023.
//

import Foundation

protocol UserBookingsProtocol {
    static func userBookings(userId: String) async throws -> (Data?, NetworkError?)
}
