//
//  LoginModel.swift
//  CarGo
//
//  Created by Andrei Mirica on 17.01.2023.
//

import Foundation

struct LoginModel {
    
    func login(loginData: LoginData) async throws -> (LoginDTO?, NetworkError?) {
        do {
            let(data, error) = try await LoginService.login(loginData: loginData)
            
            guard let data = data else {
                guard let error = error else {
                    return (nil, .unexpectedError)
                }
                
                return (nil, error)
            }
            
            do {
                let response = try JSONDecoder().decode(LoginDTO.self, from: data)
                return (response, nil)
            } catch {
                do {
                    _ = try JSONDecoder().decode(ErrorResponse.self, from: data)
                    return (nil, .invalidAccount)
                } catch {
                    return (nil, .jsonDecoder)
                }
            }
        }
    }
}
