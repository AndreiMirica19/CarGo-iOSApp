//
//  LoginProtocol.swift
//  CarGo
//
//  Created by Andrei Mirica on 17.01.2023.
//

import Foundation

protocol LoginProtocol {
    static func login(loginData: LoginData) async throws -> (Data?, NetworkError?)
}
