//
//  AccountInfoService.swift
//  CarGo
//
//  Created by Andrei Mirica on 13.02.2023.
//

import Foundation

struct AccountInfoService: AccountInfoProtocol {
    static func accountInfo(userId: String) async throws -> (Data?, NetworkError?) {
        guard let url = URL(string: ApiEndpoint.url + ApiEndpoint.accountInfo.rawValue + "/\(userId)") else {
            return (nil, .invalidURL)
        }
        print(url)
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
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
