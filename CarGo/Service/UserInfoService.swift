//
//  UserInfoService.swift
//  CarGo
//
//  Created by Andrei Mirica on 09.02.2023.
//

import Foundation

struct UserInfoService: UserInfoProtocol {
    static func userInfo(userId: String) async -> (Data?, NetworkError?) {
        guard let url = URL(string: ApiEndpoint.url + ApiEndpoint.userDetails.rawValue + "/\(userId)") else {
            return (nil, .invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return (data, nil)
        } catch {
            return (nil, .unexpectedError)
        }
    }
}
