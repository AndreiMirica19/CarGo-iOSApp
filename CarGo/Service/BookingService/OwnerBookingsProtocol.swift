//
//  OwnerBookingsProtocol.swift
//  CarGo
//
//  Created by Andrei Mirica on 19.04.2023.
//

import Foundation

protocol OwnerBookingsProtocol {
    static func ownerBookings(ownerId: String) async throws -> (Data?, NetworkError?)
}
