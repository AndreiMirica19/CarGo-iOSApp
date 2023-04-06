//
//  ToggleFavoriteCarService.swift
//  CarGo
//
//  Created by Andrei Mirica on 06.04.2023.
//

import Foundation

struct ToggleFavoriteCarService: ToggleFavoriteCarProtocol {
    
    static func toggleFavoriteCar(userId: String, carId: String) async throws -> (Data?, NetworkError?) {
        guard var urlComponents = URLComponents(string: ApiEndpoint.url + ApiEndpoint.toggleFavoriteCar.rawValue) else {
            return (nil, .invalidURL)
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "id", value: userId),
            URLQueryItem(name: "carId", value: carId)
        ]
        
        guard let url = urlComponents.url else {
            return(nil, .invalidURL)
        }
        
        var networkError: NetworkError?
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "PUT"
        
        do {
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
