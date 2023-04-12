//
//  BookCarProtocol.swift
//  CarGo
//
//  Created by Andrei Mirica on 11.04.2023.
//

import Foundation

protocol BookCarProtocol {
    static func bookCar(bookCarData: BookCarData) async throws -> (Data?, NetworkError?)
}
