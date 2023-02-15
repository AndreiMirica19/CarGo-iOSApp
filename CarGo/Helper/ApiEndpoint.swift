//
//  ApiEndpoint.swift
//  CarGo
//
//  Created by Andrei Mirica on 09.02.2023.
//

import Foundation

enum ApiEndpoint: String {
    static let url = "http://localhost:8080"
    
    case register = "/register"
    case login = "/login"
    case editProfile = "/editUserDetails"
    case userDetails = "/userDetails"
    case accountInfo = "/accountInfo"
    case changeEmail = "/changeEmail"
    case changePhoneNumber = "/changePhoneNumber"
    case changePassword = "/changePassword"
}
