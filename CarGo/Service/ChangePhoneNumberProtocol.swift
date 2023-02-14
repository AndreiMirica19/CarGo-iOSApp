//
//  ChangePhoneNumberProtocol.swift
//  CarGo
//
//  Created by Andrei Mirica on 14.02.2023.
//

import Foundation

protocol ChangePhoneNumberProtocol {
    static func changePhoneNumber(userId: String, phoneNumber: String) async throws -> (Data?, NetworkError?)
}
