//
//  HTTPURLResponseExtension.swift
//  CarGo
//
//  Created by Andrei Mirica on 15.02.2023.
//

import Foundation

extension HTTPURLResponse {
    
    func toNetworkError() -> NetworkError? {
        switch self.statusCode {
        case 200, 201, 202:
            return nil
            
        case 400:
            return .badRequest
            
        case 401:
            return .unauthorized
            
        case 403:
            return .forbidden
            
        case 404:
            return .notfound
            
        case 500:
            return .internalError
            
        default:
            return .unexpectedError
        }
    }
}
