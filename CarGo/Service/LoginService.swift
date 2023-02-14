//
//  LoginService.swift
//  CarGo
//
//  Created by Andrei Mirica on 17.01.2023.
//

import Foundation

struct LoginService: LoginProtocol {
    static func login(loginData: LoginData) async throws -> (Data?, NetworkError?) {
        
        guard let url = URL(string: "http://localhost:8080/login") else {
            return (nil, .invalidURL )
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let jsonData = try JSONEncoder().encode(loginData)
            request.httpBody = jsonData
            let (data, _) = try await URLSession.shared.data(for: request)

            return (data, nil)
        } catch {
            let errorCode = (error as NSError).code
            switch errorCode {
            case -1004:
                return (nil, .serverDown)
            default:
                return (nil, .unexpectedError)
            }
        }
    }
}
