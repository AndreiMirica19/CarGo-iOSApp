//
//  BookingStatusProtocol.swift
//  CarGo
//
//  Created by Andrei Mirica on 18.04.2023.
//

import Foundation

protocol BookingStatusProtocol {
    static func bookingStatus(bookingId: String, status: String) async throws -> (Data?, NetworkError?)
}
