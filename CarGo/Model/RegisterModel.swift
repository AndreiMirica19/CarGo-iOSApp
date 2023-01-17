//
//  Register.swift
//  CarGo
//
//  Created by Andrei Mirica on 15.01.2023.
//

import Foundation

struct RegisterModel {
    
    func register(registerData: RegisterData) async throws -> (Response?, NetworkError?) {
        do {
          let (data, error) =  try await RegisterService.register(registerData: registerData)
            guard let data = data else {
                guard let error = error else {
                    return (nil, .unexpectedError)
                }

                return (nil, .unexpectedError)
            }
            do {
                let response = try JSONDecoder().decode(Response.self, from: data)
                return (response, nil)
            } catch {
                return (nil, .jsonDecoder)
            }
        }
        catch {
            return (nil, .unexpectedError)
        }
    }
}
