//
//  ChangePasswordService.swift
//  CarGo
//
//  Created by Andrei Mirica on 15.02.2023.
//

import Foundation

struct ChangePasswordService: ChangePasswordProtocol {
    static func changePassword(userId: String, password: String) async throws -> (Data?, NetworkError?) {
        guard var urlComponents = URLComponents(string: ApiEndpoint.url + ApiEndpoint.changePassword.rawValue) else {
            return (nil, .invalidURL)
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "id", value: userId),
            URLQueryItem(name: "password", value: password)
        ]
        
        guard let url = urlComponents.url else {
            return(nil, .invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "PUT"
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
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
