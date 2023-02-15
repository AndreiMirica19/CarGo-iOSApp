//
//  ChangeEmailProtocol.swift
//  CarGo
//
//  Created by Andrei Mirica on 14.02.2023.
//

import Foundation

protocol ChangeEmailProtocol {
    static func changeEmail(userId: String, email: String) async throws -> (Data?, NetworkError?)
}
