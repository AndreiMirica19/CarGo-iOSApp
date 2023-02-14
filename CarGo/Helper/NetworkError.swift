//
//  NetworkError.swift
//  CarGo
//
//  Created by Andrei Mirica on 15.01.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidBody
    case unexpectedError
    case jsonDecoder
    case invalidAccount
    case serverDown
    
    func getErrorMessage() -> String {
        switch self {
        case .invalidURL, .invalidBody, .unexpectedError:
            return "Unexpected error.Please try again later!"
        case .jsonDecoder:
            return "Data can't be decoded"
        case .invalidAccount:
            return "Invalid email/password"
        case .serverDown:
            return "Could not connect to the server.Please try again later"
        }
    }
}
