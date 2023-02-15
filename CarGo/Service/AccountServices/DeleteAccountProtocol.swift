//
//  DeleteAccountProtocol.swift
//  CarGo
//
//  Created by Andrei Mirica on 15.02.2023.
//

import Foundation

protocol DeleteAccountProtocol {
    static func deleteAccount(userId: String) async throws -> (Data?, NetworkError?)
}
