//
//  BookingRepository.swift
//  CarGo
//
//  Created by Andrei Mirica on 11.04.2023.
//

import Foundation

struct BookingRepository {
    static let shared = BookingRepository()
    
    func bookCar(bookCarData: BookCarData) async throws -> (Response?, NetworkError?) {
        let (data, error) = try await BookCarService.bookCar(bookCarData: bookCarData)
        
        guard let data = data else {
            guard let error = error else {
                return (nil, .unexpectedError)
            }
            
            return (nil, error)
        }
        
        do {
            let response = try JSONDecoder().decode(Response.self, from: data)
            return (response, nil)
        } catch {
            return (nil, .unexpectedError)
        }
    }
}
