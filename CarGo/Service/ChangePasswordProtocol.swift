//
//  ChangePasswordProtocol.swift
//  CarGo
//
//  Created by Andrei Mirica on 15.02.2023.
//

import Foundation

protocol ChangePasswordProtocol {
    static func changePassword(userId: String, password: String) async throws -> (Data?, NetworkError?)
}
