//
//  HostStatsProtocol.swift
//  CarGo
//
//  Created by Andrei Mirica on 20.04.2023.
//

import Foundation

protocol HostStatsProtocol {
    static func hostStats(hostId: String) async throws -> (Data?, NetworkError?)
}
