//
//  Response.swift
//  CarGo
//
//  Created by Andrei Mirica on 16.01.2023.
//

import Foundation

struct Response: Decodable, Equatable {
    let message: String
    let statusCode: Int
}
