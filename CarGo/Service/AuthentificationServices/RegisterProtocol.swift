//
//  RegisterProtocol.swift
//  CarGo
//
//  Created by Andrei Mirica on 15.01.2023.
//

import Foundation

protocol RegisterProtocol {
    static func register(registerData: RegisterData) async throws -> (Data?, NetworkError?)
}
