//
//  RegisterService.swift
//  CarGo
//
//  Created by Andrei Mirica on 15.01.2023.
//

import Foundation

struct RegisterService: RegisterProtocol {
    static func register(registerData: RegisterData) async throws -> (Data?, NetworkError?) {
        guard let url = URL(string: "http://localhost:8080/register") else {
            return (nil, .invalidURL )
        }
        
        var networkError: NetworkError?
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let jsonData = try JSONEncoder().encode(registerData)
            request.httpBody = jsonData
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse {
                networkError = httpResponse.toNetworkError()
              }

            return (data, networkError)
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
