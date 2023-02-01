//
//  LoginDTO.swift
//  CarGo
//
//  Created by Andrei Mirica on 17.01.2023.
//

import Foundation

struct LoginDTO: Decodable, Equatable {
    let email: String
    let id: String
    let password: String
    let phone: String
    let name: String
}
