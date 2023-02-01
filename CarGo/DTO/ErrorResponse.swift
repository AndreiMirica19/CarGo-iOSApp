//
//  ErrorResponse.swift
//  CarGo
//
//  Created by Andrei Mirica on 24.01.2023.
//

import Foundation

struct ErrorResponse: Decodable {
    let error: Bool
    let reason: String
}
