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
    case badRequest
    case unauthorized
    case forbidden
    case notfound
    case internalError
    case encodeError
    
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
        case .badRequest, .unauthorized, .forbidden, .notfound, .internalError, .encodeError:
            return "There are some problems with the request.Please try again later"
        }
    }
}
