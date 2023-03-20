//
//  HostInfoProtocol.swift
//  CarGo
//
//  Created by Andrei Mirica on 20.03.2023.
//

import Foundation

protocol HostInfoProtocol {
    
    static func hostInfo(id: String) async throws -> (Data?, NetworkError?)
}
