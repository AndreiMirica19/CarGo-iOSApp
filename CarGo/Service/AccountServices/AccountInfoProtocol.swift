//
//  AccountInfo.swift
//  CarGo
//
//  Created by Andrei Mirica on 13.02.2023.
//

import Foundation

protocol AccountInfoProtocol {
    static func accountInfo(userId: String) async throws -> (Data?, NetworkError?)
}
